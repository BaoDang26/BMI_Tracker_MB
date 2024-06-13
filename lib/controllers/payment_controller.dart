import 'dart:developer';

import 'package:flutter_health_menu/screens/service_package/payment_results/fail_screen.dart';
import 'package:flutter_health_menu/screens/service_package/payment_results/success_screen.dart';
import 'package:flutter_health_menu/screens/service_package/payment_results/user_cancel_screen.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';

import '../repositories/payment_repository.dart';

class PaymentController extends GetxController {
  String zpTransToken = '';
  String payResult = '';

  Future<void> planOrder(double payAmount) async {
    int amount = (payAmount * 24505).round();
    DateTime orderTime = DateTime.now();

    var result = await createOrder(amount);
    print('result: ${result}');
    if (result != null) {
      zpTransToken = result.zptranstoken!;
      log("zpTransToken $zpTransToken'.");

      FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).then((value) {
        switch (value) {
          case FlutterZaloPayStatus.cancelled:
            payResult = "User Huỷ Thanh Toán";
            Get.offAll(UserCancelScreen());
            break;
          case FlutterZaloPayStatus.success:
            payResult = "Thanh toán thành công";
            Get.offAll(PaymentSuccessScreen(),
                arguments: [orderTime, payAmount]);
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
}
