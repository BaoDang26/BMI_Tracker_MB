import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_health_menu/config/firebase_messaging_service.dart';
import 'package:flutter_health_menu/controllers/advisor_controller.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/controllers/profile_controller.dart';
import 'package:flutter_health_menu/firebase_options.dart';
import 'package:get/get.dart';

class BottomNavBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // Khởi tạo các controller
    Get.lazyPut(() => HomePageController.withDate("2024-05-31"));
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AdvisorController());

    // Khởi tạo Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Khởi tạo dịch vụ Firebase Messaging và đăng ký với GetX
    final firebaseMessagingService = FirebaseMessagingService();
    await firebaseMessagingService.init();
    Get.put(firebaseMessagingService);
  }
}
