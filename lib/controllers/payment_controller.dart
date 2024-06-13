import 'dart:math';

import 'package:flutter_health_menu/models/combinded_order_request_model.dart';
import 'package:flutter_health_menu/models/create_order_response_model.dart';
import 'package:flutter_health_menu/models/plan_model.dart';
import 'package:flutter_health_menu/screens/plan/payment_results/fail_screen.dart';
import 'package:flutter_health_menu/screens/plan/payment_results/success_screen.dart';
import 'package:flutter_health_menu/screens/plan/payment_results/user_cancel_screen.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';

import '../repositories/order_repository.dart';
import '../repositories/payment_repository.dart';

class PaymentController extends GetxController {
  String zpTransToken = '';
  String payResult = '';

  Future<void> planOrder(PlanModel planModel) async {
    int amount = (planModel.price! * 24505).round();
    DateTime orderTime = DateTime.now();

    var result = await createOrder(amount);
    print('result: ${result}');
    if (result != null) {
      zpTransToken = result.zptranstoken!;
      print("zpTransToken $zpTransToken'.");

      FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).then((value) async {
        switch (value) {
          case FlutterZaloPayStatus.cancelled:
            payResult = "User Huỷ Thanh Toán";
            Get.offAll(UserCancelScreen());
            break;
          case FlutterZaloPayStatus.success:
            payResult = "Thanh toán thành công";
            // await createOrderTransaction(planModel, result);
            Get.offAll(PaymentSuccessScreen(),
                arguments: [orderTime, planModel.price]);
            break;
          case FlutterZaloPayStatus.failed:
            payResult = "Thanh toán thất bại";
            Get.offAll(PaymentFailedScreen());
            break;
          default:
            payResult = "Thanh toán thất bại";
            Get.offAll(PaymentFailedScreen());
            break;
        }
      });
    }
  }

  String generateOrderNumber() {
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

  createOrderTransaction(PlanModel planModel, CreatePaymentResponse result) async {
    // tạo order request
    OrderRequestModel orderRequest = OrderRequestModel(
        description:
        "Order Plan id[${planModel.planID}] with duration ${planModel
            .planDuration} days",
        amount: planModel.price!,
        advisorID: planModel.advisorID!,
        planDuration: planModel.planDuration!,
        orderNumber: generateOrderNumber());

    // tạo transaction request
    TransactionRequestModel transactionRequest = TransactionRequestModel(
        zpTransToken: zpTransToken,
        payDate: DateTime.now().toString(),
        transactionMessage: result.returnmessage!,
        transactionSubMessage: result.subreturnmessage!,
        amount: orderRequest.amount,
        orderToken: result.ordertoken!);

    // tạo object request để lưu trữ thông tin order lên server
    CombinedOrderRequestModel requestModel = CombinedOrderRequestModel(
        orderRequest: orderRequest, transactionRequest: transactionRequest);

    // gọi api gửi thông tin
    var response = await OrderRepository.createOrderTransaction(requestModel);

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
}
