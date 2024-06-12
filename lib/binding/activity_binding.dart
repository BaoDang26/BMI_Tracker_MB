import 'package:flutter_health_menu/controllers/activity_details_controller.dart';
import 'package:get/get.dart';


class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityDetailsController());
  }
}
