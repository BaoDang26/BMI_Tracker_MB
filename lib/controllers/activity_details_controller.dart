import 'dart:convert';

import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:flutter_health_menu/models/exercise_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

import '../repositories/daily_record_repository.dart';
import '../util/preUtils.dart';

class ActivityDetailsController extends GetxController {
  RxList<ActivityLogModel> activityLogModels = RxList.empty();
  RxList<ExerciseModel> workoutModels = RxList.empty();
  RxList<ExerciseModel> exerciseModels = RxList.empty();
  var isLoading = true.obs;
  late String date;

  @override
  Future<void> onInit() async {
    // date = PrefUtils.getString('date')!;
    // nhận date được chuyển từ Homepage qua Get.arguments
    date = Get.arguments;

    print('date : $date}');
    await getAllActivityLogByDate(date);

    if (activityLogModels.isEmpty) {
      activityLogModels.add(ActivityLogModel(
          recordID: 1,
          duration: 10,
          caloriesBurned: 500,
          activityLogID: 1,
          activityName: "test",
          emoji: '💪'));
    }

    if (workoutModels.isEmpty) {
      workoutModels.add(new ExerciseModel(
        duration: 50,
        emoji: '💪',
        caloriesBurned: 200,
        exerciseName: 'Nâng tạ',
        exerciseID: 1,
        isActive: true
      ));
    }
    super.onInit();
    isLoading.value = false;
  }

  Future<void> getAllActivityLogByDate(String date) async {
    // Show dialog prgoress khi đợi kết quả từ API
    // ProgressDialogUtils.showProgressDialog();

    // gọi APi lấy danh sách activity log by date
    var response = await DailyRecordRepository.getAllActivityLogByDate(date);

    // Ẩn dialog sau khi nhận kếu quả từ api
    // ProgressDialogUtils.hideProgressDialog();

    // kiểm tra kết  quả
    if (response.statusCode == 200) {
      // 200 là thành công, Convert kết quả vào activityLogModels
      activityLogModels.value = exerciseLogModelsFromJson(response.body);
    } else if (response.statusCode == 400) {
      // 400 lỗi format date
      Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else if (response.statusCode == 204) {
      //empty list activity log
      Get.snackbar("Empty", "Empty activity");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> createActivityLogByExercise(ExerciseModel workoutModel) async {}
}
