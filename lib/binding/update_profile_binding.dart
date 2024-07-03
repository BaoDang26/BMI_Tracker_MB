import 'package:flutter_health_menu/controllers/update_profile_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController());
  }
}
