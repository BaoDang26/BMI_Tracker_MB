import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter_health_menu/constants/preUtils.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:get/get.dart';

import '../screens/login/login_screen.dart';

class ProfileController extends GetxController{


  Future<void> logout() async {
    PrefUtils.clearPreferencesData();
    await CometChat.logout(
      onSuccess: (message) {},
      onError: (excep) {},
    );

    await AccountRepository.logout();
    Get.off(LoginScreen());

  }

}
