import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController.withDate("2024-05-31"));
  }
}
