import 'dart:math';

import 'package:flutter_health_menu/models/combinded_order_request_model.dart';
import 'package:flutter_health_menu/models/create_order_response_model.dart';
import 'package:flutter_health_menu/models/plan_model.dart';
import 'package:flutter_health_menu/repositories/booking_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';

import '../repositories/payment_repository.dart';
import '../screens/payment/payment_results/fail_screen.dart';
import '../screens/payment/payment_results/pay_success_screen.dart';
import '../screens/payment/payment_results/user_cancel_screen.dart';

class PaymentController extends GetxController {
  String zpTransToken = '';
  String payResult = '';
  late Rx<BookingRequestModel> bookingRequest = BookingRequestModel(
          planDuration: 0,
          advisorID: 0,
          amount: 0,
          planID: 0,
          description: "",
          bookingNumber: "ssss")
      .obs;

  Rx<PlanModel> planModel = PlanModel().obs;
  RxString advisorName = ''.obs;

  @override
  Future<void> onInit() async {
    // lấy plan từ argument [0] là plan
    planModel.value = await Get.arguments[0];
    // arguments[1] là advisor name từ Plan controller
    advisorName.value = await Get.arguments[1];

    // Lấy giá trị plan name

    // tạo booking request
    bookingRequest.value = BookingRequestModel(
        description: "Booking Plan ID{${planModel.value.planID}}"
            " with duration ${planModel.value.planDuration} days",
        amount: planModel.value.price!,
        planID: planModel.value.planID!,
        advisorID: planModel.value.advisorID!,
        planDuration: planModel.value.planDuration!,
        bookingNumber: generateBookingNumber());

    super.onInit();
  }

  Future<void> planOrder() async {
    // chuyển đổi tiền sáng int
    int amount = (planModel.value.price!).round();
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
            await createBookingTransaction(result);

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

  String generateBookingNumber() {
    // random booking number bằng date và chuôi random
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

  createBookingTransaction(CreatePaymentResponse result) async {
    // tạo transaction request
    TransactionRequestModel transactionRequest = TransactionRequestModel(
        zpTransToken: zpTransToken,
        // format time của LocalDateTime back-end
        payDate: DateTime.now().format("yyyy-MM-dd'T'HH:mm:ss"),
        transactionMessage: result.returnmessage!,
        transactionSubMessage: result.subreturnmessage!,
        amount: bookingRequest.value.amount!,
        orderToken: result.ordertoken!);

    // tạo object request để lưu trữ thông tin booking lên server
    CombinedBookingRequestModel requestModel = CombinedBookingRequestModel(
        bookingRequest: bookingRequest.value,
        transactionRequest: transactionRequest);

    // gọi api gửi thông tin
    var response = await BookingRepository.createBookingTransaction(requestModel);
    print('response: ${response.body}');
    // kiểm tra kết quả
    // if (response.statusCode == 200) {
    //   // convert list exercises from json
    //   planModels.value = planModelsFromJson(response.body);
    // } else if (response.statusCode == 204) {
    //   // xóa list hiện tại khi kết quả là rỗng
    //   planModels.clear();
    //   // quay về màn hình trước đó
    //   Get.back();
    //
    //   // thông báo lỗi
    //   Get.snackbar("No plan exists", "Advisor hasn't made any plans yet.");
    // } else {
    //   Get.snackbar("Error server ${response.statusCode}",
    //       jsonDecode(response.body)['message']);
    // }
  }

  void goToHome() {
    Get.offAllNamed(AppRoutes.bottomNavScreen);
    // Get.back();
  }
}
