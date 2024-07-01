import 'package:flutter_health_menu/controllers/booking_history_controller.dart';
import 'package:get/get.dart';

class BookingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingHistoryController());
  }
}
