import 'package:flutter_health_menu/routes/app_routes.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage++;
    } else {
      Get.offNamed(AppRoutes.initialRoute);
    }
  }

  void goToLoginScreen() {
    Get.offNamed(AppRoutes.loginScreen);
  }
}
