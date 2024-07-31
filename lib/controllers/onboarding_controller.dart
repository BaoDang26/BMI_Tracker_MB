import 'package:flutter_health_menu/routes/app_routes.dart';
import 'package:get/get.dart';

import '../util/preUtils.dart';

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
    if (PrefUtils.getAccessToken() != null) {
      Get.offAllNamed(AppRoutes.bottomNavScreen);
      return;
    }

    Get.offNamed(AppRoutes.loginScreen);
  }
}
