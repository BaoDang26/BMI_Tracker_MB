import 'dart:convert';
import 'dart:developer';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/constants/preUtils.dart';
import 'package:flutter_health_menu/controllers/userbodymax_controller.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/userBodyMax_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants.dart';
import '../screens/login/login_screen.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var email = '';
  var password = '';
  var errorString = ''.obs;
  var isLoading = true.obs;
  var loginedMember = MemberModel().obs;
  var userinfo = UserBodyMaxModel().obs;

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

  // Future<void> loginComet(UserModel loginUser) async {
  //   final user = await CometChat.getLoggedInUser();
  //   if (user == null) {
  //     await CometChat.login(loginUser.userId!.toString(), cometAuthKey,
  //         onSuccess: (User user) {
  //       log("User logged in successfully  ${user.name}");
  //     }, onError: (CometChatException ce) {
  //       log("Login failed with exception:  ${ce.message}");
  //     });
  //   }
  // }

  void logoutComet() {
    CometChat.logout(onSuccess: (message) {
      debugPrint("Logout successful with message $message");
    }, onError: (CometChatException ce) {
      debugPrint("Logout failed with exception:  ${ce.message}");
    });
  }

  Future<String?> login(BuildContext context) async {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return null;
    }

    loginFormKey.currentState!.save();

    LoginModel loginMember = LoginModel(
        email: emailController.text, password: passwordController.text);

    var response =
        await MemberRepository.postLogin(loginToJson(loginMember), 'user/login');
    // if (response == "Something wrong!") {
    //   Navigator.of(context).pop();
    //   errorString.value = "Username or password is incorrect!";
    //   return errorString.value;
    // }
    var data = json.decode(response);
    // if (data == 400) {
    //   Navigator.of(context).pop();
    //   errorString.value = "Username or password is incorrect!";
    //   return errorString.value;
    // }
    loginedMember.value = MemberModel.fromJson(data);
    // userinfo.value = UserBodyMaxModel.fromJson(data);
    // log("user id: ${loginedUser.value.userId!}");

    PrefUtils.setAccessToken(data["accessToken"]);
    PrefUtils.setRefreshToken(data["refreshToken"]);

    // log("userbodymaxs: ${loginedUser.value.userbodymaxs!}");
    // await prefs.setString('loginUser', loginedUser.value.userId!);
    // await loginComet(loginedUser.value);
    errorString.value = "";
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // if (loginedUser.value.userbodymaxs == null) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           content: Text('Provide more information for the account!'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Get.offAll(RegisterInfoScreen(), arguments: loginedUser);
    //               },
    //               child: const Text('UPDATE NOW'),
    //             )
    //           ],
    //         );
    //       });
    // } else {
      Get.offAll(BottomNavScreen(), arguments: userinfo);
    // }

    // log("Login User:  ${loginedUser.toString()}");
    isLoading.value = false;
  }

  Future<void> logout(BuildContext context) async {
    // Alert.showLoadingIndicatorDialog(context);
    final prefs = await SharedPreferences.getInstance();
    PrefUtils.clearPreferencesData();
    final status = await prefs.remove('loginUser');
    logoutComet();
    print(status);
    Navigator.of(context).pop();
    Get.offAll(LoginScreen());
  }
}
