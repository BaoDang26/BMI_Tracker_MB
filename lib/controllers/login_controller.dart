import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/login_comet_model.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../util/app_export.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  RxBool passwordVisible = true.obs;

  var loginedMember = LoginCometModel().obs;
  var email = '';
  var password = '';
  var errorString = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    errorString.obs;
  }

  @override
  void onClose() {
    // dispose controller
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
    if (value.isEmpty) {
      return "password is invalid";
    }
    return null;
  }

  // Login Comet
  Future<void> loginComet(LoginCometModel loginMember) async {
    final user = await CometChat.getLoggedInUser();
    if (user == null) {
      await CometChat.login(loginMember.accountID!.toString(), cometAuthKey,
          onSuccess: (User user) {
        log("User logged in successfully  ${user.name}");
      }, onError: (CometChatException ce) async {
        if (ce.code == "ERR_UID_NOT_FOUND") {
          await registerComet(loginMember);
        }
        log("Login failed with exception:  ${ce.message}");
      });
    }
  }

  Future<void> registerComet(LoginCometModel loginMember) async {
    CometChat.createUser(
      User(
        name: loginMember.fullName!,
        uid: loginMember.accountID.toString(),
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

  void logoutComet() {
    CometChat.logout(onSuccess: (message) {
      debugPrint("Logout successful with message $message");
    }, onError: (CometChatException ce) {
      debugPrint("Logout failed with exception:  ${ce.message}");
    });
  }

  Future<void> login(BuildContext context) async {
    // Show loading khi đợi xác thực login
    isLoading.value = true;

    // kiểm tra các field đã hợp lệ chưa
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();

    // tạo login model
    LoginModel loginMember = LoginModel(
        email: emailController.text, password: passwordController.text);

    // gọi api check login
    http.Response response = await MemberRepository.postLogin(
        loginToJson(loginMember), 'auth/loginMember');

    // mỗi lần nhấn button login sẽ xóa text trong password
    passwordController.clear();

    // Kiểm tra status code trả về
    if (response.statusCode == 202) {
      //202 là login lần đầu chưa có thông tin member cần bổ sung thêm thông ti

      // show dialog bổ sung thông tin member
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Provide more information for the account!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.registerMemberScreen,
                        arguments: response.body);
                  },
                  child: const Text('UPDATE NOW'),
                )
              ],
            );
          });
    } else if (response.statusCode == 500) {
      errorString.value = 'Timeout error occurred!';
    } else if (response.statusCode == 200) {
      // code 200 login thành công

      String jsonResult = utf8.decode(response.bodyBytes);
      var data = json.decode(jsonResult);
      print('data:${data}');
      // loginedMember.value = MemberModel.fromJson(data);

      // lưu accessToken và refresh token vào SharedPreferences

      PrefUtils.setAccessToken(data["accessToken"]);
      // log('a:${data["accessToken"]}');
      PrefUtils.setRefreshToken(data["refreshToken"]);

      errorString.value = "";
      loginedMember.value = LoginCometModel.fromJson(data);
      await loginComet(loginedMember.value);

      // chuyển sang màn hình Home
      Get.offAllNamed(AppRoutes.bottomNavScreen);
    } else if (response.statusCode == 400) {
      // Cập nhật errorString khi bắt được lỗi
      errorString.value = 'Your email or password is incorrect!!';
    } else if (response.statusCode == 403) {
      errorString.value = 'Your Account Requires Verification';
    }

    // ẩn dialog loading
    isLoading.value = false;
  }

  void goToForgetPasswordScreen() {
    Get.toNamed(AppRoutes.forgotPasswordScreen);
  }

  void goToRegisterScreen() {
    Get.toNamed(AppRoutes.registerScreen);
  }
}
