import 'package:flutter_health_menu/util/app_export.dart';

class AnalysisController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToWeightStatistics() {
    Get.toNamed(AppRoutes.statisticsWeightScreen);
  }

  void goToCaloriesStatistics() {
    Get.toNamed(AppRoutes.statisticsCaloriesScreen);
  }
}
