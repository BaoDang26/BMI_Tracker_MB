import 'dart:convert';

import 'package:flutter_health_menu/controllers/payment_controller.dart';
import 'package:flutter_health_menu/models/plan_model.dart';
import 'package:flutter_health_menu/repositories/plan_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class PlanController extends GetxController {
  // biến chứa toàn bộ plan của advisor
  RxList<PlanModel> planModels = RxList.empty();
  RxInt test = 1.obs;

  @override
  Future<void> onInit() async {
    // nhận advisorID từ màn hình Advisor details
    int advisorID = Get.arguments;

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
    print('orderPLan');
    var paymentController = Get.put(PaymentController());
    paymentController.planOrder(plan.price!);
  }
}
