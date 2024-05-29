import 'dart:async';
import 'dart:developer';

import 'package:flutter_health_menu/controllers/food_controller.dart';
import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/models/models.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/ingredient_repository.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';

class IngredientController extends GetxController {
  var foodList = <FoodModel>[].obs;
  var ingredientList = <RecipeModel>[].obs;

  var isLoading = true.obs;
  final foodController = Get.put(FoodController());

  @override
  void onInit() {
    getIngredientByFoodId(foodId: foodController.foodList[0].foodID.toString());
    // Timer.periodic(const Duration(seconds: 3), (timer) {
    //   log("Getting new ingredient every 3s");
    //   getIngredientByFoodId(foodId: foodController.foodList[0].foodId!);
    // });
  }

  Future<void> getIngredientByFoodId({required String foodId}) async {
// var data = await UserRepository.getListTrainer();

    var response = await IngredientRepository.getIngredientByFoodId(
        "recipe/foodId?foodId=$foodId");

    log('ingredient: ${response}');
    if (response != null) {
      // var data = BlogModel.fromJson(jsonDecode(response));

      ingredientList.value = recipeModelFromJson(response);
    }
    isLoading.value = false;
    update();
  }
}
