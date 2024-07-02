import 'dart:convert';

import 'package:flutter_health_menu/models/plan_model.dart';
import 'package:flutter_health_menu/repositories/plan_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class PlanController extends GetxController {
  // biến chứa toàn bộ plan của advisor
  RxList<PlanModel> planModels = RxList.empty();
  RxInt test = 1.obs;

  @override
  Future<void> onInit() async {
    // nhận advisorID từ màn hình Advisor details (0 là ID, 1 là fullName)
    int advisorID = await Get.arguments[0];

    // gọi api lấy danh sách plan của advisro
    await getAllPlanByAdvisorID(advisorID);

    super.onInit();
  }

  Future<void> getAllPlanByAdvisorID(int advisorID) async {
    var response = await PlanRepository.getAllPlanByAdvisorID(advisorID);

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // convert list exercises from json
      planModels.value = planModelsFromJson(response.body);

      // Tìm vị trí của Plan có numberOfUses nhiều nhất
      int indexOfMostUsedPlan = planModels.indexWhere((plan) =>
          plan.numberOfUses ==
          planModels
              .map((plan) => plan.numberOfUses)
              .reduce((a, b) => a! > b! ? a : b));

      // Đặt popular = true cho Plan có numberOfUses nhiều nhất
      if (indexOfMostUsedPlan != -1) {
        planModels[indexOfMostUsedPlan].popular = true;
      }
    } else if (response.statusCode == 204) {
      // xóa list hiện tại khi kết quả là rỗng
      planModels.clear();
      // quay về màn hình trước đó
      Get.back();

      // thông báo lỗi
      Get.snackbar("No plan exists", "Advisor hasn't made any plans yet.");
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }

  void orderPlan(int index) {
    var plan = planModels[index];
    // arguments tại [1] là advisor Name
    Get.toNamed(AppRoutes.paymentScreen, arguments: [plan, Get.arguments[1]]);
    // print('orderPLan');
    // var paymentController = Get.put(PaymentController());
    // paymentController.planOrder(plan);
  }
}
