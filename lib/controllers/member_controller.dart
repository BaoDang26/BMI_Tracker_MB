import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  var advisorList = <MemberModel>[].obs;
  // var ingredientList = <IngredientModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchAdvisors();

    super.onInit();
  }

  Future<void> fetchAdvisors() async {
    var data = await MemberRepository.getListAdvisor();
    // foodList.value = foodModelFromJson(data);
    advisorList.value = memberModelFromJson(data);
    isLoading.value = false;
    update();
  }
}
