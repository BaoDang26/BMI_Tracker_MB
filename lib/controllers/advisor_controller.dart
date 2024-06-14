import 'dart:convert';

import 'package:flutter_health_menu/models/advisor_model.dart';
import 'package:flutter_health_menu/repositories/advisor_repository.dart';
import 'package:flutter_health_menu/routes/app_routes.dart';
import 'package:get/get.dart';

class AdvisorController extends GetxController {
  var isLoading = true.obs;
  var advisorList = <AdvisorModel>[].obs;
  var advisorModel = AdvisorModel().obs;

  @override
  Future<void> onInit() async {
    // load data
    await fetchAdvisors();
    super.onInit();
  }

  Future<void> fetchAdvisors() async {
    // gọi API lấy danh sách trainer
    var response = await AdvisorRepository.getListAdvisorWithDetails();

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // convert list exercises from json
      advisorList.value = advisorsModelFromJson(response.body);
    } else if (response.statusCode == 204) {
      // xóa list hiện tại khi kết quả là rỗng
      advisorList.clear();
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
    isLoading.value = false;
    update();
  }

  void goToAdvisorDetails(int index) {
    Get.toNamed(AppRoutes.advisorDetailsScreen,
        arguments: advisorList[index].advisorID);
  }

  void getBack() {
    Get.back();
  }

  void goToChoosePlan(int index) {
    // chuyển sang màn hình plan và truyền advisorID
    // print('advisroID: ${advisorModel.value.advisorID}');
    Get.toNamed(AppRoutes.planScreen,
        arguments: [advisorList[index].advisorID, advisorList[index].fullName]);
  }

  void goToBlogScreen(int index) {
    Get.toNamed(AppRoutes.blogScreen, arguments: advisorList[index].advisorID);
  }
}
