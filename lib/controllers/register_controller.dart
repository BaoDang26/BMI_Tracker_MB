import 'dart:convert';
import 'dart:developer';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_sdk/models/user.dart' as CometUser;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/config/constants.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/models/register_account_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/register/register_complete.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  late String genderValue;
  RxBool passwordVisible = true.obs;
  RxBool confirmPasswordVisible = true.obs;

  var fullName = '';
  var email = '';
  var phoneNumber = '';
  late RxString birthday = 'yyyy-MM-dd'.obs;

  // var birthday = '';
  var gender = '';
  var password = '';
  var rePassword = '';
  var errorString = ''.obs;
  var isLoading = false.obs;
  var registeredAccount = MemberModel().obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    genderValue = 'Male';
    isLoading.value = false;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }

  String? validateFullName(String value) {
    if (value.isEmpty || value.length < 5) {
      return "Full name must have more than 5 characters";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty ||
        (!value.contains('@gmail.com') && !value.contains('@fpt.edu.vn'))) {
      return "email is invalid";
    }
    return null;
  }

  String? validatePassword(String value) {
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
    } else if (value != passwordController.text) {
      return "Password does not match";
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "PhoneNumber is invalid";
    } else if (value.length < 10) {
      return "PhoneNumber have at least 10 numbers.";
    }
    return null;
  }

  Future<String?> registerEmail(BuildContext context) async {
    isLoading.value = true;
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return null;
    }
    registerFormKey.currentState!.save();
    // Alert.showLoadingIndicatorDialog(context);
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    RegisterAccountModel registerAccount = RegisterAccountModel(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneNumberController.text,
      gender: genderValue,
      birthday: dateFormat.parse(birthday.value),
    );

    http.Response response = await MemberRepository.registerAccount(
        registerAccountModelToJson(registerAccount), 'auth/register');
    String jsonResult = utf8.decode(response.bodyBytes);

    var data = json.decode(jsonResult);
    // kiểm tra kết quả
    if (response.statusCode == 200) {
      MemberModel currentMember = MemberModel.fromJson(data);
      await registerComet(currentMember);
      Get.offAll(() => RegisterComplete());
    } else if (response.statusCode == 400) {
      print('register failed!!!!');
    } else if (response.statusCode == 500) {
      log(jsonDecode(response.body)['message']);
    } else {
      log(jsonDecode(response.body)['message']);
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }

    errorString.value = '';

    isLoading.value = false;
    return null;
  }

  Future<void> registerComet(MemberModel member) async {
    CometChat.createUser(
      CometUser.User(
        name: member.fullName!,
        uid: member.accountID.toString(),
        // avatar: member.accountPhoto,
      ),
      cometAuthKey,
      onSuccess: (message) {
        debugPrint('Register successfully: $message');
      },
      onError: (CometChatException ce) {
        debugPrint('Create member failed: ${ce.message}');
      },
    );
  }
}
