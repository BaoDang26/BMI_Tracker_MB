import 'package:get/get.dart';

import '../controllers/advisor_details_controller.dart';

class AdvisorDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvisorDetailsController());
  }
}
