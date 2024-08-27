import 'dart:convert';
import 'dart:math';
import 'dart:developer' as Developer;

import 'package:flutter_health_menu/models/combinded_order_request_model.dart';
import 'package:flutter_health_menu/models/create_order_response_model.dart';
import 'package:flutter_health_menu/models/package_model.dart';
import 'package:flutter_health_menu/repositories/subscription_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';

import '../repositories/payment_repository.dart';
import '../screens/payment/payment_results/fail_screen.dart';
import '../screens/payment/payment_results/pay_success_screen.dart';
import '../screens/payment/payment_results/user_cancel_screen.dart';

class PaymentController extends GetxController {
  String zpTransToken = '';
  String payResult = '';
  late Rx<SubscriptionRequestModel> subscriptionRequest =
      SubscriptionRequestModel(
              packageDuration: 0,
              advisorID: 0,
              amount: 0,
              packageID: 0,
              description: "",
              subscriptionNumber: "ssss")
          .obs;

  Rx<PackageModel> packageModel = PackageModel().obs;
  RxString advisorName = ''.obs;
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    // lấy plan từ argument [0] là plan
    packageModel.value = await Get.arguments[0];
    // arguments[1] là advisor name từ Plan controller
    advisorName.value = await Get.arguments[1];

    // Lấy thông tin subsciption hiện tại của member đang login
    DateTime endDateOfPlan = DateTime.parse(
        jsonDecode(PrefUtils.getString("logged_member")!)["endDateOfPlan"]);
    // kieerm tra trạng thái gia hạn hay subsciption mới
    if (endDateOfPlan.isBefore(DateTime.now())) {
      endDateOfPlan = DateTime.now();
    }
    startDate.value = endDateOfPlan.format();
    endDate.value = endDateOfPlan
        .add(Duration(days: packageModel.value.packageDuration ?? 0))
        .format();

    // tạo subsciption request
    subscriptionRequest.value = SubscriptionRequestModel(
        description:
            " Subscription Package code {${packageModel.value.packageCode}}"
            " with duration ${packageModel.value.packageDuration} days",
        amount: packageModel.value.price,
        packageID: packageModel.value.packageId!,
        advisorID: packageModel.value.advisorId!,
        packageDuration: packageModel.value.packageDuration!,
        subscriptionNumber: generateSubscriptionNumber());

    super.onInit();
  }

  Future<void> planOrder() async {
    // chuyển đổi tiền sáng int
    int amount = (packageModel.value.price!).round();
    // handle create order từ Payment repository
    var result = await createOrder(amount);

    // kiểm tra kết quả
    if (result != null) {
      zpTransToken = result.zptranstoken!;
      print("zpTransToken $zpTransToken'.");

      // mở zalo pay sdk
      FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).then((value) async {
        // kiểm tra kết quả
        switch (value) {
          // Show bottomSheet theo từng thạnh thái thanh toán
          case FlutterZaloPayStatus.cancelled:
            payResult = "User Huỷ Thanh Toán";
            Get.bottomSheet(UserCancelScreen(), isDismissible: false);
            break;
          case FlutterZaloPayStatus.success:
            payResult = "Thanh toán thành công";
            // gửi order và thông tin transaction về server
            await createSubscriptionTransaction(result);

            // mở bottom sheet và không cho dismiss
            Get.bottomSheet(PaymentSuccessScreen(), isDismissible: false);
            break;
          case FlutterZaloPayStatus.failed:
            payResult = "Thanh toán thất bại";
            Get.bottomSheet(PaymentFailedScreen(), isDismissible: false);
            break;
          default:
            payResult = "Thanh toán thất bại";
            Get.bottomSheet(PaymentFailedScreen(), isDismissible: false);
            break;
        }
      });
    }
  }

  String generateSubscriptionNumber() {
    // random subsciption number bằng date và chuôi random
    final now = DateTime.now();
    final random = Random();

    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    final randomNumber = random.nextInt(1000000).toString().padLeft(6, '0');

    return '$year$month$day$hour$minute$second$randomNumber';
  }

  createSubscriptionTransaction(CreatePaymentResponse result) async {
    isLoading.value = true;
    // tạo transaction request
    TransactionRequestModel transactionRequest = TransactionRequestModel(
        zpTransToken: zpTransToken,
        // format time của LocalDateTime back-end
        payDate: DateTime.now().format("yyyy-MM-dd'T'HH:mm:ss"),
        transactionMessage: result.returnmessage!,
        transactionSubMessage: result.subreturnmessage!,
        amount: subscriptionRequest.value.amount!,
        orderToken: result.ordertoken!);

    // tạo object request để lưu trữ thông tin subsciption lên server
    CombinedSubscriptionsRequestModel requestModel =
        CombinedSubscriptionsRequestModel(
            subscriptionRequest: subscriptionRequest.value,
            transactionRequest: transactionRequest);

    // gọi api gửi thông tin
    var response = await SubscriptionsRepository.createSubscriptionsTransaction(
        requestModel);
    // kiểm tra kết quả
    if (response.statusCode == 201) {
      // convert list exercises from json
      print('response 201:${response.body}');
    } else {
      print('response error:${response.body}');
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
    isLoading.value = false;
  }

  void goToHome() {
    Get.offAllNamed(AppRoutes.bottomNavScreen);
    // Get.back();
  }
}
