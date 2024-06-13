import 'dart:convert';

import 'package:flutter_health_menu/models/advisor_model.dart';
import 'package:flutter_health_menu/repositories/advisor_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../screens/service_package/service_package_screen.dart';

class AdvisorDetailsController extends GetxController {
  var advisorModel = AdvisorModel().obs;

  @override
  Future<void> onInit() async {
    // Nhận advisor ID từ Argument từ Advisor screen
    int advisorID = Get.arguments;

    await getAdvisorByID(advisorID);

    super.onInit();
  }

  getAdvisorByID(int advisorID) async {
    // gọi repository lấy thông tin advisor
    var response = await AdvisorRepository.getAdvisorByID(advisorID);

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // chuyển dổi từ json sang advisor model
      advisorModel.value = AdvisorModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 204) {
      // Quay về màn hình trước đó khi advisor không tồn tại
      Get.back();
      Get.snackbar(
          "Advisor does not exist!", jsonDecode(response.body)['message']);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }

  void goToChoosePlan() {
    Get.to(ServicePackageScreen());
  }
}
