import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_details_controller.dart';
import 'package:flutter_health_menu/screens/activity/widget/activity_Item.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActivityLogView extends StatelessWidget {
  var controller = Get.find<ActivityDetailsController>();

  ActivityLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.activityLogModels.length,
          itemBuilder: (context, index) {
            var activityLog = controller.activityLogModels[index];
            return Slidable(
              key: Key(activityLog.activityLogID.toString()),
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (context) {
                    controller.editMealLog(index);
                  },
                  backgroundColor: Color(0xFF1FBE1B),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    controller.removeActivityLog(index);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ]),
              child: ActivityItem(
                  emoji: controller.activityLogModels[index].emoji,
                  name: "${controller.activityLogModels[index].activityName} ",
                  duration:
                      "${controller.activityLogModels[index].duration} min",
                  kcal:
                      "${controller.activityLogModels[index].caloriesBurned} kcal"),
            );
          }),
    );
  }
}
