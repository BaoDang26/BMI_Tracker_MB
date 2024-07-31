import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/register_member_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../screens/bottom_nav/bottom_nav_screen.dart';
import '../util/app_export.dart';

class RegisterMemberController extends GetxController {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  // late TextEditingController goalIDController;
  late String dietaryPreferenceController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController targetWeightController;
  late String activityLevelID;

  // var fullname = '';
  // var email = '';
  // var password = '';
  // var rePassword = '';
  var errorString = ''.obs;
  var isLoading = true.obs;
  var registeredMember = MemberModel().obs;

  @override
  void onInit() {
    print('Onitnit register Controller');
    super.onInit();
    // goalIDController = TextEditingController();
    dietaryPreferenceController = 'Standard';
    heightController = TextEditingController();
    weightController = TextEditingController();
    targetWeightController = TextEditingController();
    activityLevelID = '1';
    // genderValue = 'Male';
  }

  @override
  void onClose() {
    // goalIDController.dispose();
    // dietaryPreferenceIDController.dispose();
    heightController.dispose();
    weightController.dispose();
    targetWeightController.dispose();
    // activityLevelID.dispose();
    super.onClose();
  }

  String? validateHeight(String value) {
    if (value.isEmpty || value.length < 10) {
      return "Height is invalid";
    }
    return null;
  }

  String? validateWeight(String value) {
    if (value.isEmpty) {
      return "Weight is invalid";
    }
    return null;
  }

  // String? validateWeight (String value) {
  //   if (value.isEmpty || value == null) {
  //     return "TargetWeight can't be empty";
  //   }
  //   // else if (value.length < 6) {
  //   //   return "Password have at least 6 words.";
  //   // }
  //   return null;
  // }

  // String? validateActivityLevelID(String value) {
  //   if (value.isEmpty || value == null) {
  //     return "Weight is invalid";
  //   }
  //   return null;
  // }

  Future<void> registerMember() async {
    isLoading = true.obs;
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    registerFormKey.currentState!.save();
    // Alert.showLoadingIndicatorDialog(context);

    RegisterMemberModel registerMember = RegisterMemberModel(
      // goalId: int.parse(goalIDController.text),
      dietaryPreference: dietaryPreferenceController.toString(),
      height: int.parse(heightController.text),
      weight: int.parse(weightController.text),
      targetWeight: int.parse(targetWeightController.text),
      activityLevelId: int.parse(activityLevelID.toString()),
    );
    print('aaaa');
    http.Response response = await MemberRepository.registerMember(
        registerMemberToJson(registerMember), 'member/createNew');

    // nếu tạo mới member thành công vào thẳng trang home
    if (response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.bottomNavScreen);
    } else {
      errorString.value = 'Error create member information';
    }

    isLoading.value = false;
  }

// Future<void> registerComet(MemberModel member) async {
//   CometChat.createMember(
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
