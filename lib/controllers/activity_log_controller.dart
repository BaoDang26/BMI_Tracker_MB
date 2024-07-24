import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_health_menu/controllers/filter_exercise_controller.dart';
import 'package:flutter_health_menu/models/exercise_log_model.dart';
import 'package:flutter_health_menu/models/exercise_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/models/workout_exercise_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/activity/add_activity_log_screen.dart';
import 'package:flutter_health_menu/screens/activity/model/activity_log_request.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/util/met_calculator.dart';
import 'package:flutter_health_menu/util/tag_emoji_utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../repositories/daily_record_repository.dart';
import '../screens/activity/widget/add_exercise_to_activity_log.dart';

class ActivityLogController extends GetxController {
  RxList<ActivityLogModel> activityLogModels = RxList.empty();
  RxList<WorkoutExerciseModel> workoutExerciseModels = RxList.empty();
  List<ExerciseModel> exerciseModels = List.empty(growable: true);

  RxInt caloriesBurned = 0.obs;

  late String date;
  var currentPage = RxInt(1);

  int size = 8;

  final PagingController<int, ExerciseModel> pagingController =
      PagingController(firstPageKey: 0);

  late TextEditingController activityNameEditController;

  late TextEditingController caloriesBurnedEditController;

  late TextEditingController durationEditController;
  var isLoading = false.obs;

  RxBool isButtonDisable = true.obs;

  @override
  Future<void> onInit() async {
    await fetchActivitiesData();
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> fetchActivitiesData() async {
    isLoading.value = true;

    // Lấy tất cả exercise có phân trang và ưu tiên
    pagingController.addPageRequestListener((pageKey) async {
      final controller = Get.find<FilterExerciseController>();
      var tagChecked = controller.tagChecked;

      await getAllExercisePaging(pageKey, tagChecked.value.tagID);
    });

    // nhận date được chuyển từ Homepage qua Get.arguments
    date = Get.arguments;

    // Lấy danh sách activity Log bằn date
    await getAllActivityLogByDate(date);

    // Lấy danh sách exercise trong workout
    await getExerciseInWorkout();

    isLoading.value = false;
  }

  Future<void> getAllActivityLogByDate(String date) async {
    // gọi APi lấy danh sách activity log by date
    var response = await DailyRecordRepository.getAllActivityLogByDate(date);

    // kiểm tra kết  quả
    if (response.statusCode == 200) {
      // 200 là thành công, Convert kết quả vào activityLogModels
      print('response.body:${response.body}');
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
        caloriesBurned: int.parse(caloriesBurnedEditController.text.isEmpty
            ? "0"
            : caloriesBurnedEditController.text),
        duration: int.parse(durationEditController.text),
        exerciseID: -1,
        dateOfActivity: date);

    var response =
        await DailyRecordRepository.createActivityLog(activityLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với activity log model
      ActivityLogModel activityModel =
          ActivityLogModel.fromJson(jsonDecode(response.body));

      // thêm activity log mới vào list hiện tại
      activityLogModels.add(activityModel);

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

  Future<void> createActivityLog(int index) async {
    ActivityLogRequest activityLogRequest = ActivityLogRequest(
        activityName: activityNameEditController.text,
        emoji: TagEmojiUtils.getEmojiForTag(exerciseModels[index].tagID),
        caloriesBurned: int.parse(caloriesBurnedEditController.text.isEmpty
            ? "0"
            : caloriesBurnedEditController.text),
        duration: int.parse(durationEditController.text),
        exerciseID: exerciseModels[index].exerciseID,
        dateOfActivity: date);

    var response =
        await DailyRecordRepository.createActivityLog(activityLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với activity log model
      ActivityLogModel activityModel =
          ActivityLogModel.fromJson(jsonDecode(response.body));

      // tìm index Activity logs với exerciseID có tồn tại chưa
      int i = activityLogModels.indexWhere((activity) =>
          activity.exerciseID == exerciseModels[index].exerciseID);
      print('i:$i');
      if (i > -1) {
        activityLogModels[i] = activityModel;
      } else {
        // thêm activity log mới vào list hiện tại
        activityLogModels.add(activityModel);
      }

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

  Future<void> createActivityLogByWorkoutExercise(
      WorkoutExerciseModel workoutExerciseModel) async {
    MemberModel memberModel =
        MemberModel.fromJson(jsonDecode(PrefUtils.getString("logged_member")!));

    // tính calories theo công thức met
    int caloriesBurned = MetCalculator.calculateCaloriesBurned(
        workoutExerciseModel.met!,
        memberModel.weight!,
        workoutExerciseModel.duration!);

    ActivityLogRequest activityLogRequest = ActivityLogRequest(
        activityName: workoutExerciseModel.exerciseName,
        emoji: workoutExerciseModel.emoji,
        caloriesBurned: caloriesBurned,
        duration: workoutExerciseModel.duration!,
        exerciseID: workoutExerciseModel.exerciseID,
        dateOfActivity: date);
    var response =
        await DailyRecordRepository.createActivityLog(activityLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với activity log model
      ActivityLogModel activityModel =
          ActivityLogModel.fromJson(jsonDecode(response.body));

      // tìm index Activity logs với exerciseID có tồn tại chưa
      int index = activityLogModels.indexWhere(
          (activity) => activity.exerciseID == workoutExerciseModel.exerciseID);

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
    var response = await MemberRepository.getAllWorkoutExerciseInWorkout();

    if (response.statusCode == 200) {
      // convert list exercise from json
      workoutExerciseModels.value =
          workoutExerciseModelsFromJson(response.body);
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

  Future<void> getAllExercisePaging(int page, int? tagID) async {
    try {
      var response =
          await MemberRepository.getAllExerciseWithPaging(page, size, tagID);
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
    } catch (error) {
      print('pagingController:${error.toString()}');
      pagingController.error = error;
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
    caloriesBurnedEditController = TextEditingController(text: '0');
    durationEditController = TextEditingController(text: '0');

    FocusManager.instance.primaryFocus!.unfocus();

    Get.to(() => const AddActivityLogScreen());
  }

  Future<void> goToAddExerciseToActivityLog(ExerciseModel exerciseModel) async {
    int index = exerciseModels.indexOf(exerciseModel);

    activityNameEditController =
        TextEditingController(text: exerciseModel.exerciseName);
    caloriesBurnedEditController = TextEditingController(text: '0');

    durationEditController = TextEditingController(text: '0');

    FocusManager.instance.primaryFocus!.unfocus();

    Get.to(() => AddExerciseToActivityLog(index));
  }

  void onChangeDuration(String value, int index) {
    if (value.isEmpty || value == '0') {
      isButtonDisable.value = true;
      caloriesBurnedEditController.text = "0";
    } else {
      int duration = 0;
      try {
        duration = int.parse(value);
      } catch (e) {}
      if (duration > 0) {
        MemberModel memberModel = MemberModel.fromJson(
            jsonDecode(PrefUtils.getString("logged_member")!));

        int caloriesBurned = MetCalculator.calculateCaloriesBurned(
            exerciseModels[index].met!, memberModel.weight!, int.parse(value));

        caloriesBurnedEditController.text = caloriesBurned.toString();
        isButtonDisable.value = false;
      } else {
        isButtonDisable.value = true;
        caloriesBurnedEditController.text = "0";
      }
    }
  }
}
