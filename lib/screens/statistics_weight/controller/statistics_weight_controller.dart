import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:http/http.dart' as http;

import '../../../models/statistics_bodymass_model.dart';
import '../../../repositories/member_repository.dart';
import '../../../repositories/statistics_repository.dart';
import '../../../util/app_export.dart';

class StatisticsWeightController extends GetxController {
  final GlobalKey<FormState> updateMemberFormKey = GlobalKey<FormState>();

  RxList<StatisticsMemberBodyMassModel> statisticsBodyMassModels =
      RxList.empty();

  RxString goalWeight = "0".obs;
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var errorString = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchStatisticsWeightData();

    super.onInit();
  }

  @override
  void onClose() {
    // dispose controller
    heightController.dispose();
    weightController.dispose();
    super.onClose();
  }

  String? validateHeight(String value) {
    if (value.isEmpty) {
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

  Future<void> fetchStatisticsWeightData() async {
    isLoading.value = true;
    MemberModel currentMember = MemberModel();

    currentMember =
        MemberModel.fromJson(jsonDecode(PrefUtils.getString("logged_member")!));
    goalWeight.value = currentMember.targetWeight.toString();
    DateTime date = DateTime.parse("2024-05-31");
    await getStatisticBodyMass(date.format());
    isLoading.value = false;
  }

  Future<void> updateMember() async {
    isLoading = true.obs;
    // final isValid = updateMemberFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // updateMemberFormKey.currentState!.save();

    http.Response response = await MemberRepository.updateMember(
        'bodymass/create?height=${int.parse(heightController.text)};&weight=${int.parse(weightController.text)}');

    if (response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.bottomNavScreen);
      Get.snackbar("Success", 'Update Member Success');
    } else {
      errorString.value = 'Error update member information';
    }

    isLoading.value = false;
  }

  Future<void> getStatisticBodyMass(String date) async {
    // gọi API deactivate workout
    var response = await StatisticsRepository.getStatisticBodyMass(date);
    // kiểm tra kết quả
    print('response:${response.statusCode}');
    if (response.statusCode == 200) {
      print('response.body:${response.body}');
      statisticsBodyMassModels.value =
          statisticsMemberBodyMassFromJson(response.body);
    } else if (response.statusCode == 204) {
      statisticsBodyMassModels.clear();
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }
}
