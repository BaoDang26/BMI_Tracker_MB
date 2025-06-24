import 'package:flutter_health_menu/util/app_export.dart';

import '../controllers/request_controller.dart';

class RequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestController());
  }
}
