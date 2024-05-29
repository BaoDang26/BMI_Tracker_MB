import 'dart:convert';
import 'dart:developer';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:cometchat_sdk/models/user.dart' as CometUser;
import 'package:flutter_health_menu/models/register_account_model.dart';
import 'package:flutter_health_menu/models/register_member_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:get/get.dart';

import '../config/constants.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController fullnameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  late TextEditingController birthdayController;
  late String genderValue;

  var fullname = '';
  var email = '';
  var phonenumber = '';
  var birthday = '' ;
  var gender = '';
  var password = '';
  var rePassword = '';
  var errorString = ''.obs;
  var isLoading = true.obs;
  var registeredAccount = MemberModel().obs;

  @override
  void onInit() {
    super.onInit();
    fullnameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    birthdayController = TextEditingController();
    // genderValue = 'Male';
  }

  @override
  void onClose() {
    fullnameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    birthdayController.dispose();
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
    if (value.isEmpty || value == null) {
      return "Password can't be empty";
    } else if (value.length < 6) {
      return "Password have at least 6 words.";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value != passwordController.text) {
      return "Password does not match";
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty || value == null) {
      return "PhoneNumber is invalid";
    } else if (value.length < 10) {
      return "PhoneNumber have at least 10 numbers.";
    }
    return null;
  }

  Future<String?> registerEmail(BuildContext context) async {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return null;
    }
    registerFormKey.currentState!.save();
    // Alert.showLoadingIndicatorDialog(context);

    RegisterAccountModel registerAccount = RegisterAccountModel(
      fullName: fullnameController.text,
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneNumberController.text,
      gender: genderValue,
      birthday: DateTime.parse(birthdayController.text),
    );

    var response = await MemberRepository.registerAccount(
        registerAccountModelToJson(registerAccount), 'api/auth/register');
    var data = json.decode(response);
    log('regsiter controller response: ${response.toString()}');
    print('user: ${registerAccount}');
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Account created!')));
    MemberModel currentMember = MemberModel.fromJson(data);
    // loginController.loginedUser.value = currentUser;
    // await registerComet(currentMember);
    // var data = json.decode(response.toString());

    // registeredUser.value = UserModel.fromMap(data);
    errorString.value = '';

    isLoading.value = false;
  }

  // Future<void> registerComet(currentMember member) async {
  //   CometChat.createUser(
  //     CometUser.User(
  //       name: user.fullname!,
  //       uid: user.userId!.toString(),
  //       // avatar: user.avatarUrl,
  //     ),
  //     cometAuthKey,
  //     onSuccess: (message) {
  //       debugPrint('Register successfully: $message');
  //     },
  //     onError: (CometChatException ce) {
  //       debugPrint('Create user failed: ${ce.message}');
  //     },
  //   );
  // }
}
