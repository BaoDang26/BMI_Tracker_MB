import 'dart:convert';
import 'dart:ffi';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/register_member_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/util/calculator_util.dart';
import 'package:http/http.dart' as http;
import 'package:cometchat_sdk/models/user.dart' as CometUser;

import '../config/constants.dart';

class RegisterMemberController extends GetxController {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  // late TextEditingController goalIDController;
  late String dietaryPreferenceController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController targetWeightController;
  late String activityLevelID;
  late String loginInfo;
  var errorString = ''.obs;
  var isLoading = false.obs;
  var registeredMember = MemberModel().obs;
  RxDouble bmi = 0.0.obs;
  Rx<Icon> icon = const Icon(Icons.info).obs;

  var warningMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRegisterInforData();
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

  void fetchRegisterInforData() {
    loginInfo = Get.arguments;

    dietaryPreferenceController = 'Standard';
    heightController = TextEditingController();
    weightController = TextEditingController();
    targetWeightController = TextEditingController();
    activityLevelID = '1';
    warningMessage.value = "Enter valid height first";
  }

  String? validateHeight(String value) {
    int height = value.isNum ? int.parse(value) : 0;
    if (value.isEmpty) {
      return "Height is invalid";
    } else if (height > 250 || height < 50) {
      return "Height must be within the range of 50cm to 250cm";
    }
    return null;
  }

  String? validateWeight(String value) {
    int weight = value.isNum ? int.parse(value) : 0;

    if (value.isEmpty) {
      return "Weight is invalid";
    } else if (weight > 300 || weight < 30) {
      return "Weight must be within the range of 30kg to 300kg";
    }
    return null;
  }

  String? validateTargetWeight(String value) {
    String height = heightController.text.isNum ? heightController.text : '0';
    String targetWeight = value.isNum ? value : '0';
    bmi.value = CalculatorUtil.calculateStrBMI(targetWeight, height);
    if (value.isEmpty) {
      return "TargetWeight can't be empty";
    } else if (int.parse(targetWeight) > 300 || int.parse(targetWeight) < 30) {
      return "Weight must be within the range of 30kg to 300kg";
    } else if (bmi < 16) {
      return "Body mass deficit";
    } else if (bmi >= 30 && bmi < 35) {
      return "Obesity first degree";
    } else if (bmi >= 35 && bmi < 40) {
      return "Obesity second degree";
    } else if (bmi >= 40) {
      return "Obesity third degree";
    }
    return null;
  }

  Future<void> registerMember() async {
    isLoading.value = true;
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
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
    // lấy thng tin từ login screen
    var data = json.decode(this.loginInfo);

    // Chuyển đổi json response thành Member model
    // loginedMember.value = MemberModel.fromJson(data);

    // lưu accessToken và refresh token vào SharedPreferences
    PrefUtils.setAccessToken(data["accessToken"]);
    PrefUtils.setRefreshToken(data["refreshToken"]);

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

  void targetWeightChange() {
    validateTargetWeight(targetWeightController.text);
    String height = heightController.text.isNum ? heightController.text : '0';
    String targetWeight =
        targetWeightController.text.isNum ? targetWeightController.text : '0';

    bmi.value = CalculatorUtil.calculateStrBMI(targetWeight, height);

    if (heightController.text.isEmpty) {
      icon.value = Icon(Icons.question_mark);
      warningMessage.value = "TargetWeight can't be empty";
    } else if (bmi < 16) {
      icon.value = Icon(
        Icons.error,
        color: appTheme.red500,
      );
      warningMessage.value = "Body mass deficit";
    } else if (bmi >= 16 && bmi < 18.5) {
      icon.value = Icon(
        Icons.info,
        color: appTheme.yellow500,
      );
      warningMessage.value = "Body weight deficit";
    } else if (bmi >= 18.5 && bmi < 25) {
      icon.value = Icon(
        Icons.check_circle,
        color: appTheme.green500,
      );
      warningMessage.value = "Good weight";
    } else if (bmi >= 25 && bmi < 30) {
      icon.value = Icon(
        Icons.info,
        color: appTheme.yellow500,
      );
      warningMessage.value = "Weight over";
    } else if (bmi >= 30 && bmi < 35) {
      icon.value = Icon(
        Icons.error,
        color: appTheme.red500,
      );
      warningMessage.value = "Obesity first degree";
    } else if (bmi >= 35 && bmi < 40) {
      icon.value = Icon(
        Icons.error,
        color: appTheme.red500,
      );
      warningMessage.value = "Obesity second degree";
    } else if (bmi >= 40) {
      icon.value = Icon(
        Icons.error,
        color: appTheme.red500,
      );
      warningMessage.value = "Obesity third degree";
    }
  }

  void heightEditingComplete() {
    String strHeight =
        heightController.text.isNum ? heightController.text : '0';

    int height = int.parse(strHeight);
    if (height > 250 || height < 50) {
      warningMessage.value = "Enter valid height first";
      return;
    }
    int minWeight =
        CalculatorUtil.calculateMinTargetWeight(height / 100).round();
    int maxWeight =
        CalculatorUtil.calculateMaxTargetWeight(height / 100).round();
    warningMessage.value =
        'Weight must be within the range of ${minWeight}kg to ${maxWeight}kg.';
  }
}
