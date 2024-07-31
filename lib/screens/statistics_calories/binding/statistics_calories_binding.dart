import 'package:get/get.dart';

import '../controller/statistics_calories_controller.dart';

class StatisticsCaloriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticsCaloriesController());
  }
}
