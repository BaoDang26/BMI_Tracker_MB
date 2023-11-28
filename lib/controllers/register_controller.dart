import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/user_repository.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController fullnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  late String genderValue;

  var fullname = '';
  var email = '';
  var password = '';
  var rePassword = '';
  var errorString = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fullnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    // genderValue = 'Male';
  }

  @override
  void onClose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }

  String? validateFullname(String value) {
    if (value.isEmpty || value.length < 10) {
      return "fullname must have more than 10 characters";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty || !value.contains('@gmail.com')) {
      return "email is invalid";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty || value.length < 6) {
      return "Password must have more than 6 characters";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value != passwordController.text) {
      return "Password does not match";
    }
    return null;
  }

  Future<void> registerEmail() async {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    registerFormKey.currentState!.save();
    // Alert.showLoadingIndicatorDialog(context);
    UserModel registerUser = UserModel(
      fullname: fullnameController.text,
      email: emailController.text,
      password: passwordController.text,

      // sex: genderValue,
      // dateOfBirth: doBController.text,
      // proveImageUrl: indentifyImage.value,
      // isProve: false,
    );
    var response = await UserRepository.postLogin(
        registerMailToJson(registerUser), 'user/SignUp');
    // print('regsiter controller response: ${response.toString()}');
    var data = json.decode(response);

    UserModel currentUser = UserModel.fromJson(data);
    errorString.value = '';
    isLoading.value = false;

    // if (data.toString().contains("duplicate key")) {
    //   errorString.value =
    //       'Your email has been registered, try using another one!';
    //   Navigator.of(context).pop();
    // } else {
    //   Navigator.of(context).pop();
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Account created!')));
    //   UserModel currentUser = UserModel.fromJson(data);
    //   // loginController.loginedUser.value = currentUser;
    //   // await registerComet(currentUser);
    //   // Get.to(const BottomNavScreen());
    //   Get.back();
    // }
  }
}
