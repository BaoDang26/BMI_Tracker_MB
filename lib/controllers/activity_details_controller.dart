import 'dart:convert';

import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:get/get.dart';

import '../models/meal_model2.dart';
import '../repositories/daily_record_repository.dart';
import '../util/preUtils.dart';

class ActivityDetailsController extends GetxController {
  RxList<ActivityLogModel> exerciseLogModel = RxList.empty();
  var isLoading = true.obs;
  late String date;

  @override
  Future<void> onInit() async {
    date = PrefUtils.getString('date')!;

    print('date : $date}');
    await getAllActivityLogByDate(date);

    if (exerciseLogModel.isEmpty) {
      exerciseLogModel.add(ActivityLogModel(
          recordID: 1,
          duration: 10,
          caloriesBurned: 500,
          activityLogID: 1,
          activityName: "test",
          emoji: '💪'));
    }
    super.onInit();
    isLoading.value = false;
  }

  Future<void> getAllActivityLogByDate(String date) async {
    var response = await DailyRecordRepository.getAllActivityLogByDate(date);

    if (response.statusCode == 200) {
      exerciseLogModel.value = exerciseLogModelsFromJson(response.body);
    } else if (response.statusCode == 400) {
      Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else if (response.statusCode == 204) {
      //empty list activity log
      Get.snackbar("Empty", "Empty activity");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }
}
