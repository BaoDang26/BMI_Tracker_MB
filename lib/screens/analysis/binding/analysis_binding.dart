import 'package:flutter_health_menu/screens/analysis/controller/analysis_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class AnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalysisController());
  }
}
