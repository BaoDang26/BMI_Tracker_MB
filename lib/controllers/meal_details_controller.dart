import 'dart:convert';

import 'package:flutter_health_menu/models/food_model.dart';
import 'package:flutter_health_menu/repositories/daily_record_repository.dart';
import 'package:flutter_health_menu/screens/home/model/meal_log_request.dart';
import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:get/get.dart';

import '../models/meal_log_model.dart';

class MealDetailsController extends GetxController {
  RxList<MealLogModel> mealLogModels = RxList.empty();
  var isLoading = true.obs;

  late String date;
  late String mealType;

  @override
  Future<void> onInit() async {
    print('MealDetailsController onInit');
    date = PrefUtils.getString("date")!;

    await getAllMelLogOfDateByMealType();

    super.onInit();
  }

  Future<void> getAllMelLogOfDateByMealType() async {
    var response = await DailyRecordRepository.getAllMelLogOfDateByMealType(
        date, mealType);

    if (response.statusCode == 200) {
      mealLogModels.value = mealLogModelsFromJson(response.body);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }

    isLoading.value = false;
  }

  Future<void> createMealLog() async {
    MealLogRequest mealLogRequest = MealLogRequest(
        mealType: "Breakfast",
        calories: 500,
        foodName: "Pizza",
        quantity: "1 slice",
        dateOfMeal: date);
    var response = await DailyRecordRepository.createMealLog(mealLogRequest);

    if (response.statusCode == 200) {
      MealLogModel mealLogModel =
          MealLogModel.fromJson(jsonDecode(response.body));
      mealLogModels.add(mealLogModel);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }

    isLoading.value = false;
  }

  Future<void> getMenuByMealType() async {
    var response = await DailyRecordRepository.getMenuByMealType(mealType);

    if (response.statusCode == 200) {
      // convert list foods from json
      List<FoodModel> foods = foodModelsFromJson(response.body);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }

    isLoading.value = false;
  }
}
