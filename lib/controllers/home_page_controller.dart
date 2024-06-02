import 'dart:convert';

import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/meal_repository.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/home/activity_details_screen.dart';
import 'package:flutter_health_menu/util/date_time_utils.dart';
import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:get/get.dart';

import '../models/meal_model2.dart';
import '../repositories/daily_record_repository.dart';

class HomePageController extends GetxController {
  RxList<MealModel> mealModels = RxList.empty();
  RxList<ActivityLogModel> exerciseLogModel = RxList.empty();
  var isLoading = true.obs;
  late String date;

  Rx<MemberModel> currentMember = MemberModel().obs;

  // Default constructor
  HomePageController() {
    date = DateTime.now().format();
  }

  // Named constructor with date parameter
  HomePageController.withDate(this.date);

  @override
  Future<void> onInit() async {
    print('Meal controller init');
    // Lấy thông tin member đang đăng nhập
    await fetchMemberLogged();
    // Nhận thông tin calories của các bữa ăn: default va đã ăn
    await fetchCaloriesOfMeal();
    // Lấy tất cả các hoạt động trong ngày
    await getAllActivityLogByDate();

    // lưu ngày đang được hiện lên Ui vào Preferences
    PrefUtils.setString('date', date);

    // await fetchCaloriesOfActivities();
    if (mealModels.isEmpty) {
      mealModels.add(MealModel(
          mealType: 'Breakfast default', currentCalories: 100, defaultCalories: 400));
      mealModels.add(MealModel(
          mealType: 'Lunch default', currentCalories: 100, defaultCalories: 600));
      mealModels.add(MealModel(
          mealType: 'Dinner', currentCalories: 100, defaultCalories: 100));
      mealModels.add(MealModel(
          mealType: 'Snack', currentCalories: 100, defaultCalories: 100));
    }

    isLoading.value = false;
    update();
    super.onInit();
  }

  Future<void> fetchCaloriesOfMeal() async {
    var response = await DailyRecordRepository.fetchCaloriesOfMeal(date);
    if (response.statusCode == 200) {
      mealModels.value = mealModelsFromJson(response.body);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }

    // isLoading.value = false;
    // update();
  }

  Future<void> fetchTotalCaloriesBurnedOfDate() async {
    var response =
        await DailyRecordRepository.fetchTotalCaloriesBurnedOfDate(date);
    if (response.statusCode == 200) {
      exerciseLogModel.value = exerciseLogModelsFromJson(response.body);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> getAllActivityLogByDate() async {
    var response = await DailyRecordRepository.getAllActivityLogByDate(date);

    if (response.statusCode == 200) {
      exerciseLogModel.value = exerciseLogModelsFromJson(response.body);
    } else if (response.statusCode == 400) {
      Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else if (response.statusCode == 204) {

      //empty list activity log
      // Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else {
      Get.snackbar("Error server ${response.statusCode}", json.decode(response.body)['message']);
    }
  }

  fetchMemberLogged() async {
    var response = await MemberRepository.fetchMemberLogged();
    if (response.statusCode == 200) {
      currentMember.value = MemberModel.fromJson(jsonDecode(response.body));
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }


  void goToActivityDetailsScreen() {
    // chuyển sang mn hình activity details
    Get.to(() => ActivityDetailsScreen());
  }
}
