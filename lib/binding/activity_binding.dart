 import 'package:flutter_health_menu/controllers/activity_log_controller.dart';
import 'package:get/get.dart';

import '../controllers/filter_exercise_controller.dart';


class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityLogController());
    Get.lazyPut(() => FilterExerciseController());
  }
}
