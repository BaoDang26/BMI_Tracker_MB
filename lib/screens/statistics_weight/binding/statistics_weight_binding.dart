import 'package:get/get.dart';

import '../controller/statistics_weight_controller.dart';

class StatisticsWeightBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticsWeightController());
  }
}
