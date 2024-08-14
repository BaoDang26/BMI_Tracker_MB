import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:flutter_health_menu/screens/profile/profile_screen.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:http/http.dart' as http;

class ChangePasswordController extends GetxController {
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController rePasswordController;
  RxBool oldPasswordVisible = true.obs;
  RxBool newPasswordVisible = true.obs;
  RxBool confirmPasswordVisible = true.obs;
  var errorString = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    rePasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // dispose controller
    oldPasswordController.dispose();
    newPasswordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }

  String? validateOldPassword(String value) {
    if (value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  String? validateNewPassword(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 6) {
      return "Password have at least 6 words.";
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character";
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value != newPasswordController.text) {
      return "Password does not match";
    }
    return null;
  }

  Future<void> changePassword() async {
    isLoading = true.obs;

    final isValid = changePasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    changePasswordFormKey.currentState!.save();

    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    http.Response response = await AccountRepository.changePasword(
        'accounts/change-password?oldPassword=$oldPassword&newPassword=$newPassword');

    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.bottomNavScreen);
      oldPasswordController.clear();
      newPasswordController.clear();
      rePasswordController.clear();
      Get.snackbar("Success", 'You have changed your password');
    }
    if (response.statusCode == 400) {
      Get.snackbar("Failed", 'Your old password is incorrect');
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    }

    isLoading.value = false;
  }
}
