import 'package:flutter_health_menu/screens/statistics_weight/controller/statistics_weight_controller.dart';
import 'package:get/get.dart';

class StatisticsWeightBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticsWeightController());
  }
}
