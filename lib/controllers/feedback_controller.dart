import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/schedule_controller.dart';
import 'package:flutter_health_menu/models/feedback_model.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/schedule_model.dart';
import 'package:flutter_health_menu/models/memberbodymass_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/feedback_repository.dart';
import 'package:flutter_health_menu/repositories/memberbodymass_repository.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  final GlobalKey<FormState> feedbackFormKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  // late TextEditingController typeController;
  late TextEditingController descriptionController;
  // late TextEditingController sexController;
  // var statusIsBlank = false.obs;
  late String sexValue;
  var isLoading = true.obs;
  var errorString = ''.obs;
  var meals = <String>[].obs;
  var feedback = <FeedbackModel>[].obs;
  final loginController = Get.put(LoginController());
  // final feedbackModel = FeedbackModel(
  //   title: '',
  //   type: '',
  //   description: '',
  //   userId: '',
  // ).obs;
  late MemberModel currentMember;
  late String feedbackType;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    feedbackType = 'Menu';
    descriptionController = TextEditingController();
    currentMember = loginController.loginedMember.value;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();

    super.onClose();
  }

  String? validateTitle(String value) {
    if (value.isEmpty) {
      return "Title is invalid";
    }

    return null;
  }

  String? validateDescription(String value) {
    if (value.isEmpty) {
      return "description is invalid";
    }
    return null;
  }

  Future<String?> registFeedback(BuildContext context) async {
    // {required List<String> menus}) async {
    FeedbackModel feedback = FeedbackModel(
      title: titleController.text,
      type: feedbackType,
      description: descriptionController.text,
      // sex: 0,
      // userId: currentMember.memberId.toString(),
    );

    // sex: sexController.text);

    var response = await FeedbackRepository.registerFeedback(
        registFeedbackToJson(feedback), 'feedback');

    log('feedback controller response: ${response.toString()}');
    print('feedback: ${feedback}');

    errorString.value = '';
    isLoading.value = false;
  }
}
