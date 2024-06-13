import 'package:flutter_health_menu/controllers/plan_controller.dart';
import 'package:get/get.dart';

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlanController());
  }
}
