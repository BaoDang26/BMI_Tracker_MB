import 'package:flutter_health_menu/controllers/booking_details_controller.dart';
import 'package:get/get.dart';

class BookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingDetailsController());
  }
}
