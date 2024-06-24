import 'dart:convert';

import 'package:flutter_health_menu/models/food_details_model.dart';
import 'package:flutter_health_menu/models/food_tag_basic_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:http/http.dart' as http;

class MealLogFoodController extends GetxController {
  Rx<FoodDetailsModel> foodModel = FoodDetailsModel().obs;
  RxList<FoodTag> foodTags = <FoodTag>[].obs;

  var isLoading = true.obs;
  RxBool isExpanded = false.obs;
  RxInt quantity = 0.obs;

  @override
  Future<void> onInit() async {
    await fetchFoodDetails();
    super.onInit();
  }

  Future<void> fetchFoodDetails() async {
    int foodID = Get.arguments;
    isLoading.value = true;
    await getFoodByID(foodID);
    isLoading.value = false;
  }

  Future<void> getFoodByID(int foodID) async {
    isLoading.value = true;
    http.Response response = await FoodRepository.getFoodByID(foodID);

    print('response.statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      // var data = json.decode();
      foodModel.value = FoodDetailsModel.fromJson(jsonDecode(response.body));
      foodTags.value = foodModel.value.foodTags!;
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    }
    isLoading.value = false;
  }

  Future<void> addMealLog() async {}

  void toggleContainer() {
    isExpanded.value = !isExpanded.value;
  }

  void expandContainer() {
    isExpanded.value = true;
  }

  void collapseContainer() {
    isExpanded.value = false;
  }

  void onChangedQuantity(int value) {
    quantity.value = value;
  }
}
