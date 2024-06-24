import 'package:flutter_health_menu/controllers/meal_log_food_controller.dart';
import 'package:get/get.dart';

class MealLogFoodDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MealLogFoodController());
  }
}
