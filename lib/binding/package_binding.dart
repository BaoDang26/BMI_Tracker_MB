import 'package:flutter_health_menu/controllers/package_controller.dart';
import 'package:get/get.dart';

class PackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackageController());
  }
}
