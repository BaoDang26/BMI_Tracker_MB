import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/userBodyMax_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/userBodyMax_repository.dart';
import 'package:flutter_health_menu/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserBodyMaxController extends GetxController {
  final GlobalKey<FormState> userbodymaxFormKey = GlobalKey<FormState>();
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController ageController;
  late TextEditingController sexController;
  var statusIsBlank = false.obs;
  // var isLoading = true.obs;
  final loginController = Get.put(LoginController());
  late UserModel currentUser;

  var height = '';
  var weight = '';
  var age = '';
  var sex = '';
  var errorString = ''.obs;
  var isLoading = true.obs;
  var userBodyMax1 = UserBodyMaxModel().obs;

  @override
  void onInit() {
    super.onInit();
    heightController = TextEditingController();
    weightController = TextEditingController();
    ageController = TextEditingController();
    sexController = TextEditingController();
    currentUser = loginController.loginedUser.value;

    // Timer.periodic(const Duration(seconds: 30), (timer) {
    //   log("Getting new food every 30s");
    //   fetchPosts();
    // });
  }

  @override
  void onClose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    sexController.dispose();
    super.onClose();
  }

  String? validateAge(String value) {
    if (value.isEmpty) {
      return "age is invalid";
    }
    return null;
  }

  String? validateHeight(String value) {
    if (value.isEmpty) {
      return "height is invalid";
    }
    return null;
  }

  String? validateWeight(String value) {
    if (value.isEmpty) {
      return "weight is invalid";
    }
    return null;
  }

  Future<String?> registUserBodyMax({required UserModel createdBy}) async {
    UserBodyMaxModel userBodyMax2 = UserBodyMaxModel(
      age: ageController.text,
      height: heightController.text,
      weight: weightController.text,
      createdBy: createdBy,
    );
    // sex: sexController.text);

    var response = await UserBodyMaxRepository.postUserBodyMax(
        registerBodyMaxToJson(userBodyMax2), 'userBodyMax');

    log('userbodymax controller response: ${response.toString()}');
    print('userbodymax: ${userBodyMax2}');

    // var data = json.decode(response.toString());

    // userBodyMax1.value = UserBodyMaxModel.fromMap(data);
    // errorString.value = '';

    // emailController = TextEditingController();
    // passwordController = TextEditingController();

    // log("Post userBodyMax:  ${loginedUser.toString()}");
    errorString.value = '';
    isLoading.value = false;
  }
}
