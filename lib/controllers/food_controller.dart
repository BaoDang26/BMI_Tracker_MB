import 'dart:convert';
import 'dart:developer';

import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/food_model.dart';

class FoodController extends GetxController {
  var foodList = <MenuFoodModel>[].obs;
  var ingredientList = <IngredientModel>[].obs;
  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchFoods();
  }

  Future<void> fetchFoods() async {
     http.Response response = await FoodRepository.getAllFoodInMenu();

    print('response.statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      // var data = json.decode();
      foodList.value = menuFoodModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      print('response error: ${response.body}');
     }
     isLoading.value = false;
    update();
  }
}
