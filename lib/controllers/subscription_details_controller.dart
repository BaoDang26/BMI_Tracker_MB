import 'package:flutter_health_menu/models/subscription_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class SubscriptionDetailsController extends GetxController {
  var isLoading = true.obs;
  Rx<SubscriptionModel> subscriptionModel = SubscriptionModel().obs;

  @override
  Future<void> onInit() async {
    subscriptionModel.value = Get.arguments;

    print('SubscriptionModel:${subscriptionModel.toString()}');
    // TODO: implement onInit
    super.onInit();
  }
}
