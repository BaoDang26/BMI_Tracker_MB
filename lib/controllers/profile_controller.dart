import 'dart:convert';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:get/get.dart';

import '../models/member_model.dart';
import '../screens/login/login_screen.dart';

class ProfileController extends GetxController {
  Rx<MemberModel> currentMember = MemberModel().obs;

  @override
  Future<void> onInit() async {
    await fetchMemberLogged();
    super.onInit();
  }

  fetchMemberLogged() async {
    var response = await MemberRepository.fetchMemberLogged();
    if (response.statusCode == 200) {
      currentMember.value = MemberModel.fromJson(jsonDecode(response.body));
    } else {
      Get.snackbar("Error server", json.decode(response.body)['message']);
    }
  }

  Future<void> logout(BuildContext context) async {
    // Alert.showLoadingIndicatorDialog(context);
    PrefUtils.clearPreferencesData();
    await AccountRepository.logout();

    // Navigator.of(context).pop();
    Get.offAll(const LoginScreen());
  }
}
