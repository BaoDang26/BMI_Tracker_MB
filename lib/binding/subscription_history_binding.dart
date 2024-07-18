import 'package:flutter_health_menu/controllers/subscription_history_controller.dart';
import 'package:get/get.dart';

class SubscriptionHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubscriptionHistoryController());
  }
}
