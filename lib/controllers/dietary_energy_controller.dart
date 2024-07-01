import 'dart:convert';

import 'package:get/get.dart';

import '../models/daily_record_model.dart';
import '../repositories/daily_record_repository.dart';

class DietaryEnergyController extends GetxController {
  RxInt goalCalories = 0.obs;
  RxString dailyAverage = '0'.obs;
  late String date;
  RxList<DailyRecordModel> dailyRecordModels = RxList.empty();
  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    // nhận date từ arguments
    print('aa:${Get.arguments}');
    date = Get.arguments;
    // lấy data để tạo chart
    await fetchDailyRecord();

    // empty tạo data mẫu
    if (dailyRecordModels.isEmpty) {
      dailyRecordModels.add(DailyRecordModel(
          recordID: 1,
          date: "2023-05-28",
          defaultCalories: 1000,
          totalCaloriesIn: 1200,
          totalCaloriesOut: 400));
      dailyRecordModels.add(DailyRecordModel(
          recordID: 2,
          date: "2023-05-29",
          defaultCalories: 1000,
          totalCaloriesIn: 1200,
          totalCaloriesOut: 100));
      dailyRecordModels.add(DailyRecordModel(
          recordID: 3,
          date: "2023-05-31",
          defaultCalories: 1000,
          totalCaloriesIn: 800,
          totalCaloriesOut: 100));
    }
    // tính giá trị trung bình
    dailyAverage.value = await calculateAverageCaloriesIn();

    goalCalories.value = dailyRecordModels[0].defaultCalories!;

    isLoading.value = false;
    super.onInit();
  }

  Future<String> calculateAverageCaloriesIn() async {
    // Calculate the average of totalCaloriesIn
    int totalCaloriesInSum = 0;
    for (var record in dailyRecordModels) {
      totalCaloriesInSum += record.totalCaloriesIn!;
    }

    double averageCaloriesIn = totalCaloriesInSum / dailyRecordModels.length;
    return averageCaloriesIn.toString();
  }

  fetchDailyRecord() async {
    // String date = DateTime.now().format();
    print('Date: $date');
    var response = await DailyRecordRepository.getDailyRecordInWeek(date);
    if (response.statusCode == 200) {
      dailyRecordModels.value = dailyRecordModelsFromJson(response.body);
    }else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }
}
