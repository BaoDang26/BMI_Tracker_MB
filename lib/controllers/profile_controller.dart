import 'dart:convert';

import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/routes/app_routes.dart';
import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:get/get.dart';

import '../models/member_model.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  Rx<MemberModel> currentMember = MemberModel().obs;

  @override
  Future<void> onInit() async {
    await fetchMemberLogged();
    isLoading.value = false;
    update();
    super.onInit();
  }

  fetchMemberLogged() async {
    var response = await MemberRepository.fetchMemberLogged();
    if (response.statusCode == 200) {
      currentMember.value = MemberModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server", json.decode(response.body)['message']);
    }
    isLoading.value = false;
    update();
  }

  Future<void> updateProfile() async {

  }

  Future<void> logout() async {
    // Alert.showLoadingIndicatorDialog(context);
    PrefUtils.clearPreferencesData();
    await AccountRepository.logout();

    Get.offAllNamed(AppRoutes.loginScreen);
  }

  void goToMyAdvisor() {}

  void goToBookingHistory() {
    Get.toNamed(AppRoutes.bookingHistoryScreen);
  }

  void goToAnalysis() {}

  void goToFeedback() {
    Get.toNamed(AppRoutes.feedbackScreen);
  }
}
