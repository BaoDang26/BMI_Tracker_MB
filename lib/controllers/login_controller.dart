import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/user_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var email = '';
  var password = '';
  var errorString = ''.obs;
  var isLoading = true.obs;
  var loginedUser = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty ||
        !value.contains('@gmail.com') && !value.contains('@fpt.edu.vn')) {
      return "email is invalid";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty || value.length < 4) {
      return "Password must have more than 6 characters";
    }
    return null;
  }

  Future<String?> login() async {
    final isValid = loginFormKey.currentState!.validate();

    if (!isValid) {
      return null;
    }

    loginFormKey.currentState!.save();

    LoginModel loginUser = LoginModel(
        email: emailController.text, password: passwordController.text);

    var response =
        await UserRepository.postLogin(loginToJson(loginUser), 'user/login');

    var data = json.decode(response.toString());

    loginedUser.value = UserModel.fromMap(data);
    errorString.value = "";

    // emailController = TextEditingController();
    // passwordController = TextEditingController();

    log("Login User:  ${loginedUser.toString()}");
    isLoading.value = false;
  }
}
