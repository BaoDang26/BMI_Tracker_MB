import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:flutter_health_menu/models/exercise_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/activity/add_activity_log_screen.dart';
import 'package:flutter_health_menu/screens/activity/model/activity_log_request.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../repositories/daily_record_repository.dart';

class ActivityDetailsController extends GetxController {
  RxList<ActivityLogModel> activityLogModels = RxList.empty();
  RxList<ExerciseModel> workoutModels = RxList.empty();
  RxList<ExerciseModel> exerciseModels = RxList.empty();

  RxInt caloriesBurned = 0.obs;

  late String date;
  var currentPage = RxInt(1);

  int size = 8;

  final PagingController<int, ExerciseModel> pagingController =
      PagingController(firstPageKey: 0);

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
    pagingController.addPageRequestListener((pageKey) {
      getAllExercisePaging(pageKey);
    });

    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> getAllActivityLogByDate(String date) async {
    // gọi APi lấy danh sách activity log by date
    var response = await DailyRecordRepository.getAllActivityLogByDate(date);

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
      ActivityLogModel activityModel =
          ActivityLogModel.fromJson(jsonDecode(response.body));

      // tìm index Activity logs với exerciseID có tồn tại chưa
      int index = activityLogModels.indexWhere(
          (activity) => activity.exerciseID == exerciseModel.exerciseID);

      if (index > -1) {
        activityLogModels[index] = activityModel;
      } else {
        // thêm activity log mới vào list hiện tại
        activityLogModels.add(activityModel);
      }
      // tạo thông báo thành công
      // Get.snackbar("Add new activity", "Add to activity log success!");
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

  Future<void> getExerciseInWorkout() async {
    var response = await MemberRepository.getAllExerciseInWorkout();

    if (response.statusCode == 200) {
      // convert list exercise from json
      workoutModels.value = exerciseModelsFromJson(response.body);
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

  Future<void> getAllExercisePaging(int page) async {
    var response = await MemberRepository.getAllExerciseWithPaging(page, size);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<ExerciseModel> exerciseModels = [];
      if (data['exercises'] != null) {
        // Parse exercise items from the response
        exerciseModels = exerciseModelsPagingFromJson(response.body);
      }

      final isLastPage = data['last'] as bool;
      if (isLastPage) {
        pagingController.appendLastPage(exerciseModels);
      } else {
        pagingController.appendPage(exerciseModels, page + 1);
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

  Future<void> removeActivityLog(int index) async {
    var response = await DailyRecordRepository.deleteActivityLogByID(
        activityLogModels[index].activityLogID);

    if (response.statusCode == 204) {
      Get.snackbar("Delete", "Delete activity log success");
      // xóa item trong list khi thành công
      activityLogModels.removeAt(index);
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
