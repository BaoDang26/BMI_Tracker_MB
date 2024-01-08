import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/userbodymax_controller.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/user_repository.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login/login_screen.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var email = '';
  var password = '';
  var errorString = ''.obs;
  var isLoading = true.obs;
  var loginedUser = UserModel().obs;

  // final userbodymaxController = Get.put(UserBodyMaxController());

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    errorString.obs;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty || !value.contains('@gmail.com')) {
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

  Future<String?> login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

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

    loginedUser.value = UserModel.fromJson(data);
    log("user id: ${loginedUser.value.userId!}");
    await prefs.setString('loginUser', loginedUser.value.userId!);
    errorString.value = "";
    emailController = TextEditingController();
    passwordController = TextEditingController();
    if (loginedUser.value.phoneNumber == "string") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Provide more information for the account!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.offAll(RegisterInfoScreen(), arguments: loginedUser);
                  },
                  child: const Text('UPDATE NOW'),
                )
              ],
            );
          });
    } else {
      Get.offAll(BottomNavScreen(), arguments: loginedUser);
    }

    // errorString.value = "";

    // emailController = TextEditingController();
    // passwordController = TextEditingController();

    log("Login User:  ${loginedUser.toString()}");
    isLoading.value = false;
  }

  Future<void> logout(BuildContext context) async {
    // Alert.showLoadingIndicatorDialog(context);
    final prefs = await SharedPreferences.getInstance();
    final status = await prefs.remove('loginUser');
    // logoutComet();
    print(status);
    Navigator.of(context).pop();
    Get.offAll(LoginScreen());
  }
}
