import 'package:flutter_health_menu/models/advisor_model.dart';
import 'package:flutter_health_menu/repositories/advisor_repository.dart';
import 'package:get/get.dart';

class AdvisorController extends GetxController {
  var isLoading = true.obs;
  var advisorList = <AdvisorModel>[].obs;

  @override
  void onInit() {
    fetchAdvisors();
    super.onInit();
  }

  Future<void> fetchAdvisors() async {
    var data = await AdvisorRepository.getListAdvisorWithDetails();
    // foodList.value = foodModelFromJson(data);
    advisorList.value = memberModelFromJson(data);
    isLoading.value = false;
    update();
  }
}
