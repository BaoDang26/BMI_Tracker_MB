import 'package:flutter_health_menu/controllers/advisor_controller.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/controllers/profile_controller.dart';
import 'package:get/get.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController.withDate("2024-05-31"));
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AdvisorController());
  }
}
