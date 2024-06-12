import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    // Get.lazyPut(() => ActivityDetailsController());
  }
}
