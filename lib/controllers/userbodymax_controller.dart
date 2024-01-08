import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/schedule_controller.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/schedule_model.dart';
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
  // late TextEditingController sexController;
  var statusIsBlank = false.obs;
  late String sexValue;
  var isLoading = true.obs;
  var errorString = ''.obs;
  final loginController = Get.put(LoginController());
  final scheduleController = Get.put(ScheduleController());
  final userbodymaxRequest = UserBodyMaxRequest(
          age: 0,
          heght: 0,
          sex: 0,
          weight: 0,
          userId: '',
          userBodyMaxMenus: List.empty())
      .obs;
  late UserModel currentUser;
  late ScheduleModel menuDefault;

  @override
  void onInit() {
    super.onInit();
    heightController = TextEditingController();
    weightController = TextEditingController();
    ageController = TextEditingController();
    // sexController = TextEditingController();
    sexValue = '0';
    currentUser = loginController.loginedUser.value;
    // menuDefault = scheduleController.menuDefault.value;
    // menuDefault =

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
    // sexController.dispose();
    super.onClose();
  }

  String? validateAge(String value) {
    if (value.isEmpty || value.isNumericOnly) {
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
    // userbodymaxRequest.value.weight ?? 0;
    return null;
  }

  Future<String?> registUserBodyMax(BuildContext context,
      {required List<String> menus}) async {
    UserBodyMaxRequest userBodyMax2 = UserBodyMaxRequest(
      age: int.parse(ageController.text),
      heght: int.parse(heightController.text),
      weight: int.parse(weightController.text),
      sex: 0,
      userId: currentUser.userId ?? '',
      // menuDefault: ScheduleModel(menuId: ''),
      userBodyMaxMenus: menus.isEmpty
          ? List.empty()
          : menus.map((e) => UserBodyMaxMenu(menuId: e)).toList(),
    );

    // sex: sexController.text);

    var response = await UserBodyMaxRepository.postUserBodyMax(
        userBodyMaxRequestToMap(userBodyMax2), 'userBodyMax');

    log('userbodymax controller response: ${response.toString()}');
    print('userbodymax: ${userBodyMax2}');
    // Navigator.of(context).pop();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Complete information!')));
    // Navigator.of(context).pop();

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
