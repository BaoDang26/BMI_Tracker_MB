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
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: appTheme.white,
          body: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(appTheme.green500),
            ),
          ),
        );
      }
      return Scaffold(
        backgroundColor: appTheme.grey100,
        appBar: AppBar(
          title: Text("Notifications".tr, style: theme.textTheme.headlineLarge),
        ),
        body: Obx(() {
          if (controller.notifications.isEmpty) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/not_found.png",
                      width: 128.adaptSize),
                  Text("No notifications available yet",
                      style: CustomTextStyles.titleMedium16Black),
                  // Text("body_no_results".tr, style: theme.textTheme.bodyMedium,)
                ],
              ),
            );
          }
          return Container(
            margin: EdgeInsets.only(
                top: 10.v, left: 10.h, right: 10.h, bottom: 20.v),
            child: Obx(
              () => ListView.builder(
                itemCount: controller.notifications.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      controller.markAsRead(index);
                    },
                    child: Container(
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.v),
                      decoration: BoxDecoration(
                        color: controller.notifications[index].isRead!
                            ? appTheme.white.withOpacity(0.6)
                            : appTheme.white,
                        borderRadius: index == 0
                            ? BorderRadius.only(
                                topRight: Radius.circular(10.adaptSize),
                                topLeft: Radius.circular(10.adaptSize))
                            : index == controller.notifications.length - 1
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(10.adaptSize),
                                    bottomRight: Radius.circular(10.adaptSize))
                                : BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.0.h, right: 10.0.h, top: 5.0.v),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  controller.notifications[index].createdTime!
                                      .format(),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Text(
                              "${controller.notifications[index].title}",
                              style: CustomTextStyles.titleMedium16Black,
                            ),
                            Text(
                              "${controller.notifications[index].content}",
                              style: CustomTextStyles.bodyMedium16,
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Divider(color: appTheme.grey300),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      );
    });
  }
}
