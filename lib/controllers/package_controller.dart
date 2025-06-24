import 'dart:convert';

import 'package:flutter_health_menu/models/package_model.dart';
import 'package:flutter_health_menu/repositories/plan_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class PackageController extends GetxController {
  // biến chứa toàn bộ plan của advisor
  RxList<PackageModel> packageModels = RxList.empty();
  RxInt test = 1.obs;
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    // nhận advisorID từ màn hình Advisor details (0 là ID, 1 là fullName)
    int advisorID = await Get.arguments[0];

    // gọi api lấy danh sách plan của advisro
    await getAllPlanByAdvisorID(advisorID);

    super.onInit();
  }

  Future<void> getAllPlanByAdvisorID(int advisorID) async {
    isLoading.value = true;
    var response = await PlanRepository.getAllPlanByAdvisorID(advisorID);

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // convert list exercises from json
      String jsonResult = utf8.decode(response.bodyBytes);

      packageModels.value = packageModelFromJson(jsonResult);

      // Tìm vị trí của Plan có numberOfUses nhiều nhất
      int indexOfMostUsedPlan = packageModels.indexWhere((package) =>
          package.numberOfUses ==
          packageModels
              .map((plan) => package.numberOfUses)
              .reduce((a, b) => a! > b! ? a : b));

      // Đặt popular = true cho Plan có numberOfUses nhiều nhất
      if (indexOfMostUsedPlan != -1) {
        packageModels[indexOfMostUsedPlan].popular = true;
      }
    } else if (response.statusCode == 204) {
      // xóa list hiện tại khi kết quả là rỗng
      packageModels.clear();
      // quay về màn hình trước đó
      Get.back();

      // thông báo lỗi
      Get.snackbar("No plan exists", "Advisor hasn't made any plans yet.");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
    isLoading.value = false;

  }

  void orderPlan(int index) {
    var package = packageModels[index];
    // arguments tại [1] là advisor Name
    Get.toNamed(AppRoutes.paymentScreen,
        arguments: [package, Get.arguments[1]]);
    // print('orderPLan');
    // var paymentController = Get.put(PaymentController());
    // paymentController.planOrder(plan);
  }
}
