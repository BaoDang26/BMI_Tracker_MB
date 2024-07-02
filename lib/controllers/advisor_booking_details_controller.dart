import 'dart:convert';

import 'package:flutter_health_menu/models/advisor_details_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../repositories/advisor_repository.dart';

class AdvisorBookingDetailsController extends GetxController {
  Rx<AdvisorDetailsModel> advisorDetailsModel = AdvisorDetailsModel().obs;
  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    await fetchAdvisorBookingDetails();
    super.onInit();
  }

  fetchAdvisorBookingDetails() async {
    await getAdvisorBooking();
    isLoading.value = false;
  }

  getAdvisorBooking() async {
    // gọi repository lấy thông tin advisor
    var response = await AdvisorRepository.getAdvisorBooking();

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // chuyển dổi từ json sang advisor model
      advisorDetailsModel.value =
          AdvisorDetailsModel.fromJson(json.decode(response.body));
      print('json:${response.body}');
    } else if (response.statusCode == 204) {
      // Quay về màn hình trước đó khi advisor không tồn tại
      Get.back();
      Get.snackbar(
          "Advisor does not exist!", jsonDecode(response.body)['message']);
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

  void goToMessaging() {}

  void getBack() {
    Get.back();
  }
}
