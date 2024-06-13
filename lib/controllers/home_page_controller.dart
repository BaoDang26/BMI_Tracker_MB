import 'dart:convert';

import 'package:flutter_health_menu/models/enums/EMealType.dart';
import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:flutter_health_menu/models/food_model2.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../models/meal_model2.dart';
import '../repositories/daily_record_repository.dart';
import '../screens/home/statistics_calories_screen.dart';
import '../screens/notifications/noti_screen.dart';

class HomePageController extends GetxController {
  RxList<MealModel> mealModels = RxList.empty();
  RxList<ActivityLogModel> exerciseLogModel = RxList.empty();
  var isLoading = true.obs;
  late String date;

  Rx<MemberModel> currentMember = MemberModel().obs;
  var foodList = <MenuFoodModel>[].obs;

  // Default constructor
  HomePageController() {
    date = DateTime.now().format();
  }

  // Named constructor with date parameter
  HomePageController.withDate(this.date);

  @override
  Future<void> onInit() async {
    // ProgressDialogUtils.showProgressDialog();
    // Lấy thông tin member đang đăng nhập
    await fetchMemberLogged();

    // Nhận thông tin calories của các bữa ăn: default va đã ăn
    await fetchCaloriesOfMeal();

    // Lấy tất cả các hoạt động trong ngày
    await getAllActivityLogByDate();

    await fetchFoods();

    // await fetchCaloriesOfActivities();

    isLoading.value = false;

    // ProgressDialogUtils.hideProgressDialog();

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
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      exerciseLogModel.value = exerciseLogModelsFromJson(response.body);
    } else if (response.statusCode == 400) {
      Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else if (response.statusCode == 204) {
      exerciseLogModel.value = RxList.empty();
      //empty list activity log
      // Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
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

  Future<void> fetchFoods() async {
    var response = await FoodRepository.getAllFoodInMenu();

    if (response.statusCode == 200) {
      // var data = json.decode();
      foodList.value = menuFoodModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.snackbar("Error", jsonDecode(response.body)["message"],
          duration: 5.seconds);
    }
    update();
  }

  void goToActivityDetailsScreen() {
    // chuyển sang mn hình activity details
    Get.toNamed(AppRoutes.activityDetailsScreen, arguments: date)
        ?.then((value) async {
      await getAllActivityLogByDate();
    });
  }

  void goToMealDetails(EMealType mealType) {
    // chuyển sang màn hình Meal đetails

    Get.toNamed(AppRoutes.mealDetailsScreen, arguments: [date, mealType])
        ?.then((value) async => await fetchCaloriesOfMeal());
  }

  void goToTrackCalories() {
    Get.to(() => StatisticsCaloriesScreen(), arguments: date);
  }

  void goToNotification() {
    Get.to(const NotificationScreen());
  }
}
