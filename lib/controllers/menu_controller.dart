import 'dart:developer';

import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/models/meal_model.dart';
import 'package:flutter_health_menu/models/menu_model.dart';
import 'package:flutter_health_menu/models/userBodyMax_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/repositories/menu_repository.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';

class MenuFController extends GetxController {
  var menuList = <MenuModel>[].obs;
  // var mealList = <MealModel>[].obs;
  final loginController = Get.put(LoginController());
  late UserBodyMaxModel currentUser;

  var isLoading = true.obs;

  @override
  void onInit() {
    // fetchMenuByMenuId(menu);
  }

  Future<void> fetchMenuByMenuId(String menuId) async {
    // currentUser = loginController.userinfo.value;
    // var data = await MenuReporitory.getMenuByMenuId(
    //     'menu/foodByMenuId/${currentUser.');
    // if (data != null) {
    //   menuList.value = menuModelFromJson(data);
    // }
    // isLoading.value = false;
    // update();
  }
}
