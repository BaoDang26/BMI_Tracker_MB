import 'package:flutter_health_menu/controllers/food_controller.dart';
import 'package:get/get.dart';

class FoodDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodController());
  }
}
