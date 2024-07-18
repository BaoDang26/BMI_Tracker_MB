import 'dart:convert';

import 'package:flutter_health_menu/models/notification_model.dart';
import 'package:flutter_health_menu/repositories/notification_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notificationModels = RxList.empty();

  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    await fetchNotificationScreenData();
    super.onInit();
  }

  fetchNotificationScreenData() async {
    isLoading.value = true;
    await getAllNotification();
    isLoading.value = false;
  }

  getAllNotification() async {
    var response = await NotificationRepository.getAllNotification();
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      notificationModels.value = notificationModelsFromJson(response.body);
    } else if (response.statusCode == 400) {
      Get.snackbar("Error date format", json.decode(response.body)['message']);
    } else if (response.statusCode == 204) {
      notificationModels.value = RxList.empty();
      //empty list activity log
      // Get.snackbar("Error date format", json.decode(response.body)['message']);
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

  void readAll() {}

  void readNotification(int index) {}
}
