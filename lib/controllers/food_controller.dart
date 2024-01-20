import 'dart:developer';

import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';

class FoodController extends GetxController {
  var foodList = <FoodModel>[].obs;
  var ingredientList = <IngredientModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    var data = await FoodRepository.getAllFood();
    if (data != null) {
      foodList.value = foodModelFromJson(data);
    }
    isLoading.value = false;
    update();
  }
}
