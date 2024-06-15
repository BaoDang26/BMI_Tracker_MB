import 'package:flutter_health_menu/controllers/payment_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class PaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }
}
