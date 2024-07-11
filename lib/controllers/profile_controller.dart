import 'dart:convert';

import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';

import '../models/member_model.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  Rx<MemberModel> currentMember = MemberModel().obs;

  @override
  Future<void> onInit() async {
    await fetchProfileScreenData();
    // await getMemberInformation();
    isLoading.value = false;
    super.onInit();
  }

  fetchProfileScreenData() async {
    currentMember.value = MemberModel();

    currentMember.value =
        MemberModel.fromJson(jsonDecode(PrefUtils.getString("logged_member")!));
  }

  getMemberInformation() async {
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

  Future<void> logout() async {
    // Alert.showLoadingIndicatorDialog(context);
    PrefUtils.clearPreferencesData();
    await AccountRepository.logout();

    Get.offAllNamed(AppRoutes.loginScreen);
  }

  void goToMyAdvisor() {
    // kiểm tra trạng thái booking
    bool isBooking = PrefUtils.getBool("is_booking")!;
    if (isBooking) {
      Get.toNamed(AppRoutes.advisorBookingDetailsScreen);
    } else {
      Get.snackbar("Not booking", "You haven't booked the advisor's plan yet.");
    }
  }

  void goToBookingHistory() {
    Get.toNamed(AppRoutes.bookingHistoryScreen);
  }

  void goToAnalysis() {}

  void goToFeedback() {
    Get.toNamed(AppRoutes.feedbackScreen);
  }

  goToUpdateProfileScreen() {
    // fullNameController =
    //     TextEditingController(text: currentMember.value.fullName);
    // phoneNumberController =
    //     TextEditingController(text: currentMember.value.phoneNumber);
    // genderController = TextEditingController(text: currentMember.value.gender);

    Get.toNamed(AppRoutes.updateProfileScreen)
        ?.then((value) => {fetchProfileScreenData()});
  }
}
