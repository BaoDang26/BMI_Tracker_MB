import 'dart:convert';

import 'package:flutter_health_menu/models/notification_model.dart';
import 'package:flutter_health_menu/repositories/notification_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  RxList<NotificationModel> notifications = RxList.empty();

  @override
  void onInit() {
    fetchDataNotificationScreen();
    super.onInit();
  }

  Future<void> fetchDataNotificationScreen() async {
    isLoading.value = true;
    await getAllNotification();
    isLoading.value = false;
  }

  Future<void> getAllNotification() async {
    // gọi API lấy danh sách menu history của advisor
    var response = await NotificationRepository.getAllNotification();

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // convert list menu history from json
      notifications.value = notificationsFromJson(response.body);
      notifications
          .sort((a, b) => b.notificationID!.compareTo(a.notificationID!));
    } else if (response.statusCode == 204) {
      // xóa list hiện tại khi kết quả là rỗng
      notifications.clear();
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }

  Future<void> markAsRead(int index) async {
    // gọi API lấy danh sách menu history của advisor
    var response = await NotificationRepository.markAsRead(
        notifications[index].notificationID);

    // kiểm tra kết quả
    if (response.statusCode == 204) {
      notifications[index].isRead = true;
      notifications.refresh();
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }

  Future<void> readAll(int index) async {
    // gọi API lấy danh sách menu history của advisor
    var response = await NotificationRepository.readAll();

    // kiểm tra kết quả
    if (response.statusCode == 204) {
      for (var notification in notifications) {
        notification.isRead = true;
      }
      notifications.refresh();
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }
}
