import 'dart:convert';
import 'dart:math';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';

import '../models/member_model.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  Rx<MemberModel> currentMember = MemberModel().obs;
  var isSubscription = false.obs;

  @override
  Future<void> onInit() async {
    await fetchProfileScreenData();
    // await getMemberInformation();
    isLoading.value = false;
    super.onInit();
  }

  fetchProfileScreenData() async {
    isSubscription.value = PrefUtils.getBool("is_subscription")!;
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
    await AccountRepository.logout();
    PrefUtils.clearPreferencesData();
    await CometChat.logout(
      onSuccess: (message) {
        print('log out comet success');
      },
      onError: (excep) {},
    );
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  void goToMyAdvisor() {
    // kiểm tra trạng thái subscription
    if (isSubscription.value) {
      Get.toNamed(AppRoutes.advisorSubscriptionDetailsScreen);
    } else {
      Get.snackbar(
          "Not subscription", "You haven't subscript the advisor's plan yet.");
    }
  }

  void goToSubscriptionHistory() {
    Get.toNamed(AppRoutes.subscriptionHistoryScreen);
  }

  void goToAnalysis() {
    Get.toNamed(AppRoutes.analysisScreen);
  }

  void goToRequestScreen() {
    Get.toNamed(AppRoutes.requestScreen);
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
