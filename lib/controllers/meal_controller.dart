import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/models/meal_model.dart';
import 'package:flutter_health_menu/models/meals_model.dart';
import 'package:flutter_health_menu/models/menu_id_model.dart';
import 'package:flutter_health_menu/models/models.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/meal_repository.dart';
import 'package:flutter_health_menu/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';

class MealController extends GetxController {
  static const String mID = '3cd110f1-d22d-4ca1-81b8-39c8a1049733';
  var foodList = <FoodModel>[].obs;
  var foodListByMenuId = <FoodModel>[].obs;
  // var ingredientList = <IngredientModel>[].obs;
  var isLoading = true.obs;
  final loginController = Get.put(LoginController());
  var meals = <FoodModel>[].obs;
  var menus = <MenuId>[].obs;

  String menuId = '';

  @override
  void onInit() {
    fetchFoods();
    getFoodByMenu();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      log("Getting new post every 30s");
      getFoodByMenu();
    });
    super.onInit();
  }

  Future<void> fetchFoods() async {
    var data = await FoodRepository.getAllFood();
    if (data != null) {
      foodList.value = foodModelFromJson(data);
    }
    isLoading.value = false;
    update();
  }

  Future<void> getFoodByMenu() async {
    var menuResponse = await UserRepository.getUserMenuId(
        loginController.loginedUser.value.userId!);

    menus.value = menuIdFromJson(menuResponse);

    log('Menu response: ${menus.toString()}');

    if (menus == []) {
      menuId = mID;
    } else {
      menuId = menus[0].menuId!;
    }

    var response = await MealRepository.getMealByMenuId(
        'menu/foodByMenuId?menuId=$menuId');

    log('response: ${response}');
    if (response != null) {
      meals.value = foodModelFromJson(response);
      log('meals: ${meals.toString()}');
    }
    isLoading.value = false;
    update();
  }
}
