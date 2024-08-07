import 'package:flutter_health_menu/config/firebase_messaging_service.dart';
import 'package:flutter_health_menu/controllers/advisor_controller.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/controllers/profile_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

class BottomNavBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // Khởi tạo các controller
    Get.lazyPut(
        () => HomePageController.withDate(DateTime.now().format().toString()));
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AdvisorController());

    // Khởi tạo dịch vụ Firebase Messaging và đăng ký với GetX
    final firebaseMessagingService = FirebaseMessagingService();
    await firebaseMessagingService.init();
    Get.put(firebaseMessagingService);
  }
}
