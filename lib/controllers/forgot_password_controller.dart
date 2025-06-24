import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:http/http.dart' as http;

import '../screens/forget_password/forget_password_complete_screen.dart';
import '../util/app_export.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  late TextEditingController txtEmailController;
  var errorString = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    txtEmailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // dispose controller
    txtEmailController.dispose();
    super.onClose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty || !value.contains('@gmail.com')) {
      return "email is invalid";
    }
    return null;
  }

  Future<void> forgotPassword() async {
    isLoading = true.obs;

    final isValid = forgotPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    forgotPasswordFormKey.currentState!.save();

    String email = txtEmailController.text;
    http.Response response = await AccountRepository.forgotPassword(
        'auth/forgot-password?email=$email');

    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.loginScreen);
      // isUpdate = true;
      Get.snackbar("Success", "Please get new password in your email");
    } else if (response.statusCode == 400) {
      Get.snackbar("Failed", "We couldn't find your email, please try again");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }

    isLoading.value = false;
  }
}
