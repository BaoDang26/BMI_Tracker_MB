import 'package:flutter_health_menu/controllers/advisor_subscription_details_controller.dart';
import 'package:get/get.dart';

class AdvisorSubscriptionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvisorSubscriptionDetailsController());
  }
}
