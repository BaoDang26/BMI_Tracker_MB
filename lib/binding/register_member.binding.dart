import 'package:get/get.dart';

import '../controllers/register_member_controller.dart';

class RegisterMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterMemberController());
  }
}
