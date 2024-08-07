import 'package:flutter_health_menu/controllers/activity_log_exercise_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../controllers/activity_log_controller.dart';

class ActivityLogExerciseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityLogExerciseController());
  }
}
