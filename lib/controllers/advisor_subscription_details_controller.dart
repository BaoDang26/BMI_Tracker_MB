import 'dart:convert';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter_health_menu/models/advisor_details_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../repositories/advisor_repository.dart';

class AdvisorSubscriptionDetailsController extends GetxController {
  Rx<AdvisorDetailsModel> advisorDetailsModel = AdvisorDetailsModel().obs;
  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    await fetchAdvisorSubscriptionDetails();
    super.onInit();
  }

  fetchAdvisorSubscriptionDetails() async {
    await getAdvisorSubscription();
    isLoading.value = false;
  }

  getAdvisorSubscription() async {
    // gọi repository lấy thông tin advisor
    var response = await AdvisorRepository.getAdvisorSubscription();

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // chuyển dổi từ json sang advisor model
      advisorDetailsModel.value =
          AdvisorDetailsModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 204) {
      // Quay về màn hình trước đó khi advisor không tồn tại
      Get.back();
      Get.snackbar(
          "Advisor does not exist!", jsonDecode(response.body)['message']);
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      Get.back();

      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.back();

      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }

  void goToChat() {
    Get.toNamed(AppRoutes.chatScreen, arguments: [
      advisorDetailsModel.value.accountID,
      advisorDetailsModel.value.fullName,
      advisorDetailsModel.value.accountPhoto
    ]);
  }

  void getBack() {
    Get.back();
  }
}
