import 'package:flutter_health_menu/controllers/activity_details_controller.dart';
import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.lazyPut(() => ActivityDetailsController());
  }
}
