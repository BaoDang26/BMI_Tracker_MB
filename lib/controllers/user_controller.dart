import 'dart:developer';

import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';

class UserController extends GetxController {
  var foodList = <FoodModel>[].obs;
  var trainerList = <UserModel>[].obs;
  // var ingredientList = <IngredientModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTrainers();
  }

  Future<void> fetchTrainers() async {
    var data = await UserRepository.getListTrainer();
    if (data != null) {
      // foodList.value = foodModelFromJson(data);
      trainerList.value = userModelFromJson(data);
    }
    isLoading.value = false;
    update();
  }
}
