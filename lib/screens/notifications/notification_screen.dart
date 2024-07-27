import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/notification_controller.dart';
import 'package:flutter_health_menu/models/notification_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.transparent),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          actions: [
            IconButton(
                padding: EdgeInsets.only(right: 20.h),
                onPressed: () {
                  controller.readAll();
                },
                icon: const Icon(Icons.checklist))
          ],
        ),
        body: Obx(() {
          if (controller.notificationModels.isEmpty) {
            return const Center(
              child: Text('No notifications found.'),
            );
          } else {
            return ListView.builder(
              itemCount: controller.notificationModels.length,
              itemBuilder: (context, index) {
                NotificationModel notification =
                    controller.notificationModels[index];
                return Container(
                  color: controller.notificationModels[index].isRead!
                      ? Colors.black12
                      : Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          controller.readNotification(index);
                        },
                        title: Text(notification.isRead.toString() ?? ''),
                        subtitle: Text(notification.content ?? ''),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: const Divider(),
                      )
                    ],
                  ),
                );
              },
            );
          }
        }),
      );
    });
  }
}
