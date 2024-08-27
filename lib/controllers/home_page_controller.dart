import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/daily_record_model.dart';
import 'package:flutter_health_menu/models/enums/EMealType.dart';
import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:flutter_health_menu/models/food_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/home/model/chart_data.dart';
import 'package:flutter_health_menu/screens/home/model/home_page_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../models/meal_model.dart';
import '../repositories/daily_record_repository.dart';

class HomePageController extends GetxController {
  RxList<MealModel> mealModels = RxList.empty();
  RxList<ActivityLogModel> exerciseLogModel = RxList.empty();
  var dailyRecord = DailyRecordModel();
  var homePageModel = HomePageModel().obs;
  var isLoading = false.obs;
  RxString dateHome = ''.obs;
  late DateTime date;

  RxList<ChartData> chartData = RxList.empty();

  Rx<MemberModel> currentMember = MemberModel().obs;

  // Rx<EBMIStatus> bmiStatus = EBMIStatus.normal.obs;

  var foodList = <FoodModel>[].obs;

  // Default constructor
  HomePageController() {
    date = DateTime.now();
  }

  // Named constructor with date parameter
  HomePageController.withDate(this.date);

  @override
  Future<void> onInit() async {
    await fetchHomePageData();
    super.onInit();
  }

  Future<void> fetchHomePageData() async {
    isLoading.value = true;

    if (date.format() == DateTime.now().format()) {
      dateHome.value = 'Today';
    } else {
      dateHome.value = date.format();
    }
    // Lấy thông tin member đang đăng nhập
    await fetchMemberLogged();

    // Nhận thông tin calories của các bữa ăn: default va đã ăn
    await fetchCaloriesOfMeal();

    // Lấy tất cả các hoạt động trong ngày
    await getAllActivityLogByDate();

    // lấy danh sách food trong menu của người dùng
    await fetchFoods();

    // lấy thông tin daily record
    await getDailyRecordByDate();

    isLoading.value = false;
  }

  Future<void> fetchCaloriesOfMeal() async {
    var response =
        await DailyRecordRepository.fetchCaloriesOfMeal(date.format());
    if (response.statusCode == 200) {
      String jsonResult = utf8.decode(response.bodyBytes);

      mealModels.value = mealModelsFromJson(jsonResult);
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
    // isLoading.value = false;
    // update();
  }

  Future<void> getDailyRecordByDate() async {
    var response = await MemberRepository.getDailyRecordByDate(date.format());
    if (response.statusCode == 200) {
      dailyRecord = DailyRecordModel.fromJson(jsonDecode(response.body));

      // chuyển đổi từ dailyRecord sang homepage model
      homePageModel.value.defaultCalories = dailyRecord.defaultCalories;
      homePageModel.value.totalCaloriesIn = dailyRecord.totalCaloriesIn;
      homePageModel.value.totalCaloriesOut = dailyRecord.totalCaloriesOut;
      homePageModel.value.remainingCalories = dailyRecord.defaultCalories! -
          (dailyRecord.totalCaloriesIn! - dailyRecord.totalCaloriesOut!);

      // if (homePageModel.value.remainingCalories! < 0) {
      //   homePageModel.value.remainingCalories = 0;
      // }
      homePageModel.value.currentCalories =
          dailyRecord.totalCaloriesIn! - dailyRecord.totalCaloriesOut!;
      homePageModel.refresh();
      // tạo data cho biểu đồ calories of date
      generateChartData();
      // if (homePageModel.value.currentCalories! < 0) {
      //   homePageModel.value.currentCalories = 0;
      // }
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> getAllActivityLogByDate() async {
    var response =
        await DailyRecordRepository.getAllActivityLogByDate(date.format());
    if (response.statusCode == 200) {
      String jsonResult = utf8.decode(response.bodyBytes);

      exerciseLogModel.value = exerciseLogModelsFromJson(jsonResult);
    } else if (response.statusCode == 400) {
      Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else if (response.statusCode == 204) {
      exerciseLogModel.value = RxList.empty();
      //empty list activity log
      // Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> fetchMemberLogged() async {
    var response = await MemberRepository.fetchMemberLogged();
    if (response.statusCode == 200) {
      // convert dữ liệu từ json sáng MemberModel
      String jsonResult = utf8.decode(response.bodyBytes);

      currentMember.value = MemberModel.fromJson(jsonDecode(jsonResult));
      // lưu thông tin member vào Storage
      PrefUtils.setString("logged_member", jsonEncode(currentMember.value));

      // kiểm tra member có trong thơời gian của plan
      DateTime now = DateTime.now();
      DateTime currentTimeOnly = DateTime(now.year, now.month, now.day);

      DateTime endDate = currentMember.value.endDateOfPlan!;
      print('endDate:${endDate}');
      print('currentTimeOnly:${currentTimeOnly}');
      if (endDate.isAfter(currentTimeOnly) ||
          endDate.isAtSameMomentAs(currentTimeOnly)) {
        PrefUtils.setBool("is_subscription", true);
      } else {
        PrefUtils.setBool("is_subscription", false);
      }
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> fetchFoods() async {
    var response = await FoodRepository.getAllFoodInMenu();
    if (response.statusCode == 200) {
      // var data = json.decode();
      String jsonResult = utf8.decode(response.bodyBytes);

      foodList.value = foodModelsFromJson(jsonResult);
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    }
  }

  // custom data cho biểu đồ thay đổi calories
  generateChartData() {
    chartData.clear();

    // nếu calories in < out, thì current calories âm
    if (homePageModel.value.currentCalories! < 0) {
      // nếu current calories âm lượt đồ trái màu đỏ => tập quá mức và không ăn
      chartData.add(
        ChartData('Current Calories', homePageModel.value.currentCalories!,
            Colors.red),
      );
      print('aaaa:${homePageModel.value.currentCalories}');
    } else {
      // ngược lại calories in > out lượt đồ màu xanh
      chartData.add(
        ChartData('Current Calories', homePageModel.value.currentCalories!,
            Colors.lightGreen),
      );
    }

    // kiểm tra remainingCalories có vượt ngưỡng
    if (homePageModel.value.remainingCalories! < 0) {
      // calories default < current calories thì lượt đồ phải màu đỏ => ăn nhiều
      chartData.add(
        ChartData('Remaining Calories', homePageModel.value.remainingCalories!,
            Colors.red),
      );
    } else {
      // calories default > current calories lượt đồ màu xám => ăn chưa đủ
      chartData.add(
        ChartData('Remaining Calories', homePageModel.value.remainingCalories!,
            Colors.black26),
      );
    }
  }

  void goToActivityDetailsScreen() {
    // chuyển sang mn hình activity details
    Get.toNamed(AppRoutes.activityDetailsScreen, arguments: date.format())
        ?.then((value) async {
      await fetchHomePageData();
    });
  }

  void goToMealDetails(EMealType mealType) {
    // chuyển sang màn hình Meal đetails

    Get.toNamed(AppRoutes.mealDetailsScreen,
            arguments: [date.format(), mealType])
        ?.then((value) async => await fetchHomePageData());
  }

  void goToNotification() {
    // fetchMemberLogged();
    Get.toNamed(AppRoutes.notificationScreen);
  }

  void goToFoodDetailsScreen(int index) {
    Get.toNamed(AppRoutes.foodDetailsScreen, arguments: foodList[index].foodID);
    // Get.to(const FoodDetailScreen(), arguments: [controller.foodList[index]]);
  }

  void goToWeightStatistics() {
    Get.toNamed(AppRoutes.statisticsWeightScreen, arguments: date.format())
        ?.then((value) {
      if (value != null && value) {
        fetchHomePageData();
      }
    });
  }

  void goToCaloriesStatistics() {
    Get.toNamed(AppRoutes.statisticsCaloriesScreen);
  }

  void onDatePicker(DateTime date) {
    // isLoading.value = true;
    this.date = date;

    fetchHomePageData();

    // isLoading.value = false;
  }
}
