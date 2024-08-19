import 'dart:convert';

import 'package:flutter_health_menu/models/subscription_model.dart';
import 'package:flutter_health_menu/repositories/subscription_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class SubscriptionHistoryController extends GetxController {
  // RxList<BookingModel> bookingModels = RxList.empty();
  RxList<SubscriptionModel> subscriptionModels = RxList.empty();

  // RxList.generate(
  //     10,
  //     (index) => BookingModel(
  //         amount: 100000,
  //         advisorID: 1,
  //         bookingDate: DateTime.parse("2024-05-01"),
  //         bookingID: 1,
  //         bookingNumber: "599526292929",
  //         bookingDescription: "cacscascasc",
  //         bookingStatus: "Paid",
  //         startDate: DateTime.parse("2024-05-01"),
  //         endDate: DateTime.parse("2024-06-01"),
  //         memberID: 1));

  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    await fetchSubscriptionsHistory();
    isLoading.value = false;
    super.onInit();
  }

  void goToSubscriptionsDetails(int index) {
    Get.toNamed(AppRoutes.subscriptionDetailsScreen,
        arguments: subscriptionModels[index]);
  }

  Future<void> fetchSubscriptionsHistory() async {
    var response = await SubscriptionsRepository.getAllSubscriptionByMember();
    if (response.statusCode == 200) {
      // convert list foods from json
      subscriptionModels.value = subscriptionModelsFromJson(response.body);
      subscriptionModels
          .sort((a, b) => b.subscriptionID!.compareTo(a.subscriptionID!));
    } else if (response.statusCode == 204) {
      print('list empty');
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }
}
