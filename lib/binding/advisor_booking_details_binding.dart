import 'package:get/get.dart';

import '../controllers/advisor_booking_details_controller.dart';

class AdvisorBookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvisorBookingDetailsController());
  }
}
