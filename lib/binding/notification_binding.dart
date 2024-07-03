import 'package:flutter_health_menu/controllers/notification_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}
