import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_health_menu/models/enums/EMealType.dart';
import 'package:flutter_health_menu/models/food_model.dart';
import 'package:flutter_health_menu/repositories/daily_record_repository.dart';
import 'package:flutter_health_menu/screens/meal/model/meal_log_request.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../models/meal_log_model.dart';
import '../screens/meal/add_meal_log_screen.dart';

class MealDetailsController extends GetxController {
  RxList<MealLogModel> mealLogModels = RxList.empty();
  RxList<FoodModel> foodModels = RxList.empty();
  RxList<FoodModel> foodMenuModels = RxList.empty();
  late TextEditingController foodNameEditController;

  late TextEditingController caloriesEditController;

  late TextEditingController quantityEditController;

  late String date;
  Rx<EMealType> mealType = EMealType.Snack.obs;

  @override
  Future<void> onInit() async {
    // lấy  date từ home controller qua arguments 0
    date = await Get.arguments[0];

    // lấy  mealType từ home controller qua arguments1
    mealType.value = await Get.arguments[1];

    // load thông tin meal type theo date và meal type
    await getAllMelLogOfDateByMealType();
    await getFoodsMenuByMealType();

    super.onInit();
  }

  Future<void> getAllMelLogOfDateByMealType() async {
    ProgressDialogUtils.showProgressDialog();

    // gọi API
    var response = await DailyRecordRepository.getAllMelLogOfDateByMealType(
        date, mealType.value.name);

    ProgressDialogUtils.hideProgressDialog();

    print("response.statusCode:${response.statusCode}");
    // kiểm tra response
    if (response.statusCode == 200) {
      // gán giá trị cho meal log model
      mealLogModels.value = mealLogModelsFromJson(response.body);
    } else if (response.statusCode == 204) {
      // Get.snackbar("No content", "");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> createMealLogByForm() async {
    String foodName = foodNameEditController.text;
    int calories = int.parse(caloriesEditController.text);
    String quantity = quantityEditController.text;

    MealLogRequest mealLogRequest = MealLogRequest(
        mealType: mealType.value.name,
        calories: calories,
        foodName: foodName,
        quantity: quantity,
        dateOfMeal: date);
    var response = await DailyRecordRepository.createMealLog(mealLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với Meal log model
      MealLogModel mealLogModel =
          MealLogModel.fromJson(jsonDecode(response.body));

      // thêm meal log mới vào list hiện tại
      mealLogModels.add(mealLogModel);

      // quay trở lại mà hình Meal log sau khi create thành cng
      Get.back();

      // tạo thông báo thành công
      Get.snackbar("Add new meal", "Add to meal log success!");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> createMealLogByFood(FoodModel foodCreateMeal) async {
    MealLogRequest mealLogRequest = MealLogRequest(
        mealType: mealType.value.name,
        calories: foodCreateMeal.foodCalories,
        foodName: foodCreateMeal.foodName,
        quantity: "1",
        dateOfMeal: date,
        foodID: foodCreateMeal.foodID);
    var response = await DailyRecordRepository.createMealLog(mealLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với Meal log model
      MealLogModel mealLogModel =
          MealLogModel.fromJson(jsonDecode(response.body));

      // thêm meal log mới vào list hiện tại
      mealLogModels.add(mealLogModel);

      // tạo thông báo thành công
      Get.snackbar("Add new meal", "Add to meal log success!");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> getFoodsMenuByMealType() async {
    var response =
        await DailyRecordRepository.getMenuByMealType(mealType.value.name);

    if (response.statusCode == 200) {
      // convert list foods from json
      foodMenuModels.value = foodModelsFromJson(response.body);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> removeMealLog(int index) async {
    var response = await DailyRecordRepository.deleteMealLogByID(
        mealLogModels[index].mealLogID);

    if (response.statusCode == 204) {
      Get.snackbar("Delete", "Delete meal log success");

      // xóa item trong list khi thành công
      mealLogModels.removeAt(index);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  void gotoAddMealLog() {
    foodNameEditController = TextEditingController();
    caloriesEditController = TextEditingController();
    quantityEditController = TextEditingController();
    Get.to(() => const AddMealLogScreen());
  }

  void editMealLog(int index) {}
}
