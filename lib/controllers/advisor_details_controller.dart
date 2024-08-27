import 'dart:convert';

import 'package:flutter_health_menu/models/advisor_model.dart';
import 'package:flutter_health_menu/repositories/advisor_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

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
      String jsonResult = utf8.decode(response.bodyBytes);

      advisorModel.value = AdvisorModel.fromJson(json.decode(jsonResult));
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
    }else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }

  void goToChoosePackage() {
    // chuyển sang màn hình package và truyền advisorID
    print('advisroID: ${advisorModel.value.advisorID}');
    Get.toNamed(AppRoutes.planScreen, arguments: advisorModel.value.advisorID);
  }
}
