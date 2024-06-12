import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_details_controller.dart';
import 'package:flutter_health_menu/screens/activity/widget/activity_Item.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class ActivityLogView extends StatelessWidget {
  var controller = Get.find<ActivityDetailsController>();

  ActivityLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.activityLogModels.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.activityLogModels.isEmpty
                  ? Container(
                      // height: 2,
                      color: Colors.red,
                    )
                  : ActivityItem(
                      emoji: controller.activityLogModels[index].emoji,
                      name:
                          "${controller.activityLogModels[index].activityName} ",
                      duration:
                          "${controller.activityLogModels[index].duration} min",
                      kcal:
                          "${controller.activityLogModels[index].caloriesBurned} kcal"),
            );
          }),
    );
  }
}
