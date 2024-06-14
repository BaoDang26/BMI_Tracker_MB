import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:flutter_health_menu/models/exercise_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/activity/add_activity_log_screen.dart';
import 'package:flutter_health_menu/screens/activity/model/activity_log_request.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

import '../repositories/daily_record_repository.dart';

class ActivityDetailsController extends GetxController {
  RxList<ActivityLogModel> activityLogModels = RxList.empty();
  RxList<ExerciseModel> workoutModels = RxList.empty();
  RxList<ExerciseModel> exerciseModels = RxList.empty();

  RxInt caloriesBurned = 0.obs;

  late String date;
  var currentPage = RxInt(1);

  int page = 0;
  int size = 10;

  //
  late TextEditingController activityNameEditController;

  late TextEditingController caloriesBurnedEditController;

  late TextEditingController durationEditController;

  @override
  Future<void> onInit() async {
    // nhận date được chuyển từ Homepage qua Get.arguments
    date = Get.arguments;

    // Lấy danh sách activity Log bằn date
    await getAllActivityLogByDate(date);

    // Lấy danh sách exercise trong workout
    await getExerciseInWorkout();

    // Lấy tất cả exercise có phân trang và ưu tiên
    await getAllExercisePaging();

    super.onInit();
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
      // Get.snackbar("Empty", "Empty activity");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> createActivityLogByForm() async {
    ActivityLogRequest activityLogRequest = ActivityLogRequest(
        activityName: activityNameEditController.text,
        emoji: '📝',
        caloriesBurned: int.parse(caloriesBurnedEditController.text),
        duration: int.parse(durationEditController.text),
        exerciseID: null,
        dateOfActivity: date);

    var response =
        await DailyRecordRepository.createActivityLog(activityLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với activity log model
      ActivityLogModel mealLogModel =
          ActivityLogModel.fromJson(jsonDecode(response.body));

      // thêm activity log mới vào list hiện tại
      activityLogModels.add(mealLogModel);

      // quay về màn hinh activity details
      Get.back();

      // tạo thông báo thành công
      Get.snackbar("Add new meal", "Add to meal log success!");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> createActivityLogByExercise(ExerciseModel exerciseModel) async {
    ActivityLogRequest activityLogRequest = ActivityLogRequest(
        activityName: exerciseModel.exerciseName,
        emoji: exerciseModel.emoji,
        caloriesBurned: exerciseModel.caloriesBurned,
        duration: exerciseModel.duration,
        exerciseID: exerciseModel.exerciseID,
        dateOfActivity: date);

    var response =
        await DailyRecordRepository.createActivityLog(activityLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với activity log model
      ActivityLogModel mealLogModel =
          ActivityLogModel.fromJson(jsonDecode(response.body));

      // thêm activity log mới vào list hiện tại
      activityLogModels.add(mealLogModel);

      // tạo thông báo thành công
      Get.snackbar("Add new activity", "Add to activity log success!");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> getExerciseInWorkout() async {
    var response = await MemberRepository.getAllExerciseInWorkout();

    if (response.statusCode == 200) {
      // convert list exercise from json
      workoutModels.value = exerciseModelsFromJson(response.body);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> getAllExercisePaging() async {
    var response = await MemberRepository.getAllExerciseWithPaging(page, size);

    if (response.statusCode == 200) {
      // convert list exercises from json
      exerciseModels.addAll(exerciseModelsPagingFromJson(response.body));
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> removeActivityLog(int index) async {
    var response = await DailyRecordRepository.deleteActivityLogByID(
        activityLogModels[index].activityLogID);

    if (response.statusCode == 204) {
      Get.snackbar("Delete", "Delete activity log success");
      // xóa item trong list khi thành công
      activityLogModels.removeAt(index);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> editMealLog(int index) async {}

  Future<void> goToAddActivityLog() async {
    activityNameEditController = TextEditingController();
    caloriesBurnedEditController = TextEditingController();
    durationEditController = TextEditingController();

    FocusManager.instance.primaryFocus!.unfocus();

    Get.to(() => const AddActivityLogScreen());
  }

  void selectAction(String result) {
    switch (result) {
      case 'Custom entry activity':
        goToAddActivityLog();
        break;
      case 'Chart':
        break;
    }
  }
}
