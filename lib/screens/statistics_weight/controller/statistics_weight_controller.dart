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
  bool isUpdate = false;

  RxString goalWeight = "0".obs;
  late TextEditingController txtWeightController;

  late TextEditingController txtHeightController;

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
    txtHeightController.dispose();
    txtWeightController.dispose();
    super.onClose();
  }

  String? validateHeight(String value) {
    if (value.isEmpty) {
      return "Height is invalid";
    }
    // Kiểm tra xem chiều cao phải là số dương
    int? height = int.tryParse(value);
    if (height! <= 0) {
      return "Height is invalid";
    }
    return null;
  }

  String? validateWeight(String value) {
    if (value.isEmpty) {
      return "Weight is invalid";
    }
    // Kiểm tra xem cân nặng phải là số dương
    int? weight = int.tryParse(value);
    if (weight! <= 0) {
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

  Future<void> showUpdateBodyMass() async {
    txtHeightController = TextEditingController();
    txtWeightController = TextEditingController();
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Update body mass",
      titleStyle: CustomTextStyles.titleMedium16Black,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Form(
                key: updateMemberFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 1,
                      controller: txtWeightController,
                      validator: (value) {
                        return validateWeight(value!);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Enter weight (kg)',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 1.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: txtHeightController,
                      validator: (value) {
                        return validateHeight(value!);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Enter height (cm)',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 1.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              )),
        ],
      ),
      // barrierDismissible: false,
      confirm: ElevatedButton(
        onPressed: () async {
          // validate
          final isValid = updateMemberFormKey.currentState!.validate();
          if (!isValid) {
            return;
          }
          updateMemberFormKey.currentState!.save();
          Get.back(result: true);
          updateMemberBodyMass();
        },
        style: CustomButtonStyles.outlineButtonGreen500,
        child: Text('OK', style: CustomTextStyles.bodyMedium14White),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: CustomButtonStyles.outlineButtonGrey300,
        child: Text('Cancel', style: CustomTextStyles.bodyMedium14White),
      ),
    );
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

  Future<void> updateMemberBodyMass() async {
    isLoading = true.obs;
    int height = int.parse(txtHeightController.text);
    int weight = int.parse(txtWeightController.text);

    http.Response response = await MemberRepository.updateMember(
        'bodymass/create?height=$height&weight=$weight');

    if (response.statusCode == 201) {
      // Get.offAllNamed(AppRoutes.bottomNavScreen);
      isUpdate = true;
      Get.snackbar("Success", 'Update body mass success');
    } else {
      errorString.value = 'Error update member information';
    }

    isLoading.value = false;
  }

  void getBack() {
    Get.back(result: isUpdate);
  }
}
