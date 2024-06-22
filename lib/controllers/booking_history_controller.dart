import 'dart:convert';

import 'package:flutter_health_menu/models/booking_model.dart';
import 'package:flutter_health_menu/repositories/booking_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class BookingHistoryController extends GetxController {
  // RxList<BookingModel> bookingModels = RxList.empty();
  RxList<BookingModel> bookingModels = RxList.empty();


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
    await fetchOrderHistory();
    isLoading.value = false;
    super.onInit();
  }

  void goToOrderDetails(int index) {
    Get.toNamed(AppRoutes.bookingDetailsScreen,
        arguments: bookingModels[index]);
  }

  Future<void> fetchOrderHistory() async {
    var response = await BookingRepository.getAllBookingByMember();
    if (response.statusCode == 200) {
      // convert list foods from json
      bookingModels.value = bookingModelsFromJson(response.body);
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
