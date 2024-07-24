import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';
import 'package:flutter_health_menu/models/tag_model.dart';
import 'package:flutter_health_menu/models/tag_type_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../repositories/tag_type_repository.dart';

class FilterExerciseController extends GetxController {
  RxList<TagModel> tagModels = RxList.empty();
  Rx<TagModel> tagChecked = TagModel().obs;

  void setSelected(TagModel value) {
    tagChecked.value = value;
    filterExerciseWithTag();
  }

  @override
  Future<void> onInit() async {
    await fetchFilterExerciseData();
    super.onInit();
  }

  Future<void> fetchFilterExerciseData() async {
    var response = await TagTypeRepository.getAllTagExercise();
    if (response.statusCode == 200) {
      tagModels.value = tagModelsFromJson(response.body);
      tagModels.insert(0, TagModel(tagID: -1, tagName: "All"));
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

  Future<void> filterExerciseWithTag() async {
    var activityLogController = Get.find<ActivityLogController>();
    activityLogController.pagingController.refresh();
  }
}
