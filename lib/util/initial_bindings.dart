

import 'package:flutter_health_menu/constants/preUtils.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());

  }
}