import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:get/get.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
