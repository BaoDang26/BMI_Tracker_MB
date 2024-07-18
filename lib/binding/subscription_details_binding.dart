import 'package:flutter_health_menu/controllers/subscription_details_controller.dart';
import 'package:get/get.dart';

class SubscriptionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubscriptionDetailsController());
  }
}
