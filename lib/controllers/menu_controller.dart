// import 'dart:developer';

// import 'package:flutter_health_menu/models/meal_model.dart';
// import 'package:flutter_health_menu/models/menu_model.dart';
// import 'package:flutter_health_menu/repositories/food_repository.dart';
// import 'package:flutter_health_menu/repositories/menu_repository.dart';
// import 'package:get/get.dart';

// import '../models/food_model.dart';

// class MenuFController extends GetxController {
//   var menuList = <MenuModel>[].obs;
//   var mealList = <MealModel>[].obs;

//   var isLoading = true.obs;

//   @override
//   void onInit() {
//     fetchFoods();
//   }

//   Future<void> fetchFoods() async {
//     var data = await MenuReporitory.getMenuByName();
//     if (data != null) {
//       menuList.value = menuFromJson(data);
//     }
//     isLoading.value = false;
//     update();
//   }
// }
