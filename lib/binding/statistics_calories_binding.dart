import 'package:flutter_health_menu/controllers/dietary_energy_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class StatisticsCaloriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DietaryEnergyController());
  }
}
