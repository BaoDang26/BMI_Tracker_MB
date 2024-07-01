import 'dart:convert';

import 'package:flutter_health_menu/models/food_tag_basic_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/food_details_model.dart';

class FoodController extends GetxController {
  Rx<FoodDetailsModel> foodModel = FoodDetailsModel().obs;
  RxList<FoodTag> foodTags = <FoodTag>[].obs;

  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchFoodDetails();
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

  void goToFeedBack() {
    // Get.to(const FeedbackScreen());
  }
}
