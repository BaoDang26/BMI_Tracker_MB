import 'dart:developer';

import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';

class MemberController extends GetxController {
  var advisorList = <MemberModel>[].obs;
  // var ingredientList = <IngredientModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    // fetchTrainers();
  }

  Future<void> fetchAdvisors() async {
    var data = await MemberRepository.getListAdvisor();
    if (data != null) {
      // foodList.value = foodModelFromJson(data);
      advisorList.value = memberModelFromJson(data);
    }
    isLoading.value = false;
    update();
  }
}
