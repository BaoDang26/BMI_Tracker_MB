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
  var isLoading = true.obs;
  late String date;

  RxList<ChartData> chartData = RxList.empty();

  Rx<MemberModel> currentMember = MemberModel().obs;
  var foodList = <FoodModel>[].obs;

  // Default constructor
  HomePageController() {
    date = DateTime.now().format();
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
    var response = await DailyRecordRepository.fetchCaloriesOfMeal(date);
    if (response.statusCode == 200) {
      mealModels.value = mealModelsFromJson(response.body);
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
    var response = await MemberRepository.getDailyRecordByDate(date);
    if (response.statusCode == 200) {
      dailyRecord = DailyRecordModel.fromJson(jsonDecode(response.body));

      // chuyển đổi từ dailyRecord sang homepage model
      homePageModel.value.totalCaloriesIn = dailyRecord.totalCaloriesIn;
      homePageModel.value.totalCaloriesOut = dailyRecord.totalCaloriesOut;
      homePageModel.value.remainingCalories = dailyRecord.defaultCalories! -
          (dailyRecord.totalCaloriesIn! - dailyRecord.totalCaloriesOut!);

      // if (homePageModel.value.remainingCalories! < 0) {
      //   homePageModel.value.remainingCalories = 0;
      // }
      homePageModel.value.currentCalories =
          dailyRecord.totalCaloriesIn! - dailyRecord.totalCaloriesOut!;

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
      // convert dữ liệu từ json sáng MembberModel
      currentMember.value = MemberModel.fromJson(jsonDecode(response.body));
      // lưu thông tin member vào Storage
      PrefUtils.setString("logged_member", response.body);

      // kiểm tra member có trong thơời gian của plan
      DateTime now = DateTime.now();
      DateTime currentTimeOnly = DateTime(now.year, now.month, now.day);

      DateTime endDate = currentMember.value.endDateOfPlan!;
      if (endDate.isAfter(currentTimeOnly) ||
          endDate.isAtSameMomentAs(currentTimeOnly)) {
        PrefUtils.setBool("is_booking", true);
      } else {
        PrefUtils.setBool("is_booking", false);
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
    print('response:${response.statusCode}');
    if (response.statusCode == 200) {
      // var data = json.decode();
      foodList.value = foodModelsFromJson(response.body);
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
    Get.toNamed(AppRoutes.activityDetailsScreen, arguments: date)
        ?.then((value) async {
      await fetchHomePageData();
    });
  }

  void goToMealDetails(EMealType mealType) {
    // chuyển sang màn hình Meal đetails

    Get.toNamed(AppRoutes.mealDetailsScreen, arguments: [date, mealType])
        ?.then((value) async => await fetchHomePageData());
  }

  void goToTrackCalories() {
    Get.toNamed(AppRoutes.trackingWeightScreen);
    // Get.to(() => StatisticsCaloriesScreen(), arguments: date);
  }

  void goToNotification() {
    // fetchMemberLogged();
    Get.toNamed(AppRoutes.notificationScreen);
  }

  void goToFoodDetailsScreen(int index) {
    Get.toNamed(AppRoutes.foodDetailsScreen, arguments: foodList[index].foodID);
    // Get.to(const FoodDetailScreen(), arguments: [controller.foodList[index]]);
  }
}
