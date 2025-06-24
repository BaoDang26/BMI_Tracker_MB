import 'dart:convert';

import 'package:flutter_health_menu/models/exercise_tag_basic_model.dart';
import 'package:flutter_health_menu/models/workout_exercise_model.dart';
import 'package:flutter_health_menu/repositories/exercise_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:http/http.dart' as http;

class ActivityLogExerciseController extends GetxController {
  Rx<WorkoutExerciseModel> exerciseModel = WorkoutExerciseModel().obs;
  RxList<ExerciseTag> exerciseTags = <ExerciseTag>[].obs;

  var isLoading = true.obs;

  RxBool isUpdate = false.obs;

  @override
  Future<void> onInit() async {
    await fetchExerciseDetails();

    super.onInit();
  }

  Future<void> fetchExerciseDetails() async {
    isLoading.value = true;

    final arguments = Get.arguments;
    int exerciseID = -1;
    // Kiểm tra kiểu dữ liệu của arguments
    if (arguments is int) {
      exerciseID = arguments;
      await getExerciseByID(exerciseID);
    } else if (arguments is List) {
      // arguments là list thì tranjg thái update
      isUpdate.value = true;

      // index 0 là foodID, 1 là Quantity
      exerciseID = arguments[0];
      // double quantity = arguments[1];
      await getExerciseByID(exerciseID);
    }

    isLoading.value = false;
  }

  Future<void> getExerciseByID(int exerciseID) async {
    isLoading.value = true;
    http.Response response =
        await ExerciseRepository.getExerciseByID(exerciseID);

    if (response.statusCode == 200) {
      // var data = json.decode();
      String jsonResult = utf8.decode(response.bodyBytes);

      exerciseModel.value =
          WorkoutExerciseModel.fromJson(jsonDecode(jsonResult));
      // exerciseTags.value = exerciseModel.value.!;
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    }
    isLoading.value = false;
  }
}
