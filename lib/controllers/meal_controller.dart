import 'dart:developer';

import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/models/meal_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/meal_repository.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';

class MealController extends GetxController {
  var foodList = <FoodModel>[].obs;
  var foodListByMenuId = <FoodModel>[].obs;
  // var ingredientList = <IngredientModel>[].obs;
  var isLoading = true.obs;
  final loginController = Get.put(LoginController());
  late UserModel currentUser;
  List<MealModel> meal = <MealModel>[].obs;

  @override
  void onInit() {
    fetchFoods();
    super.onInit();
    currentUser = loginController.loginedUser.value;
  }

  Future<void> fetchFoods() async {
    var data = await FoodRepository.getAllFood();
    if (data != null) {
      foodList.value = foodModelFromJson(data);
    }
    isLoading.value = false;
    update();
  }

  Future<void> getFoodByMenu({required String menuId}) async {
    var response = await MealRepository.getMealByMenuId('meal/$menuId');
    if (response != null) {
      meal = mealModelFromJson(response);
    }
    isLoading.value = false;
    update();
  }
}
