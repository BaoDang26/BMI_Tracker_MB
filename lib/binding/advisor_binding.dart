import 'package:flutter_health_menu/controllers/advisor_controller.dart';
import 'package:get/get.dart';


class AdvisorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvisorController());
  }
}
