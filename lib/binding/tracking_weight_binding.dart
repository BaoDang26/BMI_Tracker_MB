import 'package:flutter_health_menu/controllers/tracking_weight_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class TrackingWeightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackingWeightController());
  }
}
