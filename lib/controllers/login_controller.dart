import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/login_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:http/http.dart' as http;

import '../util/app_export.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  RxBool passwordVisible = true.obs;

  var email = '';
  var password = '';
  var errorString = ''.obs;

  // var loginedMember = MemberModel().obs;

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
    // if (value.isEmpty || value.length < 4) {
    //   return "Password must have more than 6 characters";
    // }
    return null;
  }

  // Login Comet
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

  // void logoutComet() {
  //   CometChat.logout(onSuccess: (message) {
  //     debugPrint("Logout successful with message $message");
  //   }, onError: (CometChatException ce) {
  //     debugPrint("Logout failed with exception:  ${ce.message}");
  //   });
  // }

  Future<void> login(BuildContext context) async {
     // Show loading dialog khi đợi xác thực login
    ProgressDialogUtils.showProgressDialog();

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
        loginToJson(loginMember), 'auth/login');

    // Kiểm tra status code trả về
    if (response.statusCode == 202) {
      //202 là login lần đầu chưa có thông tin member cần bổ sung thêm thông tin
      // convert json response
      var data = json.decode(response.body);

      // Chuyển đổi json response thành Member model
      // loginedMember.value = MemberModel.fromJson(data);

      // lưu accessToken và refresh token vào SharedPreferences
      PrefUtils.setAccessToken(data["accessToken"]);
      PrefUtils.setRefreshToken(data["refreshToken"]);
      errorString.value = "";

      // show dialog bổ sung thông tin member
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Provide more information for the account!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.registerMemberScreen);
                  },
                  child: const Text('UPDATE NOW'),
                )
              ],
            );
          });
    } else if (response.statusCode == 500) {
      errorString.value = 'Timeout error occurred!' ;
      // có lỗi từ server
      // Get.snackbar(
      //   "Error Server ${response.statusCode}",
      //   jsonDecode(response.body)["message"],
      //   duration: 5.seconds,
      //   snackPosition: SnackPosition.BOTTOM,
      //   showProgressIndicator: true,
      //   isDismissible: true,
      // );
    } else if (response.statusCode == 200) {
      // code 200 login thành công
      var data = json.decode(response.body);

      // loginedMember.value = MemberModel.fromJson(data);
      // userinfo.value = UserBodyMaxModel.fromJson(data);
      // log("user id: ${loginedUser.value.userId!}");

      // lưu accessToken và refresh token vào SharedPreferences
      PrefUtils.setAccessToken(data["accessToken"]);
      PrefUtils.setRefreshToken(data["refreshToken"]);
      errorString.value = "";

      // await prefs.setString('loginUser', loginedUser.value.userId!);
      // await loginComet(loginedUser.value);

      // chuyển sang màn hình Home
      Get.offAllNamed(AppRoutes.bottomNavScreen);
    } else {
      // Cập nhật errorString khi bắt được lỗi
      errorString.value = 'Username or password is incorrect!!';
    }
    // mỗi lần nhấn button login sẽ xóa text trong password
    passwordController.clear();

    // ẩn dialog loading
    ProgressDialogUtils.hideProgressDialog();
  }

  void goToForgetPasswordScreen() {
    Get.toNamed(AppRoutes.forgotPasswordScreen);

    print('goToForgetPasswordScreen');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const ForgetPasswordScreen(),
    //   ),
    // );
  }

  void goToRegisterScreen() {
    Get.toNamed(AppRoutes.registerScreen);

    print('goToRegisterScreen');
  }
}
