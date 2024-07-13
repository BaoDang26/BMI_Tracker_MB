
import 'package:flutter_health_menu/controllers/search_food_controller.dart';
import 'package:get/get.dart';

class SearchFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchFoodController());
  }
}
