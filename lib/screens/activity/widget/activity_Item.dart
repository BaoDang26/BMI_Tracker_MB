import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';

import '../../../util/app_export.dart';

class ActivityItem extends StatelessWidget {
  final IconData? icon;
  // final String? emoji;
  final String name;
  final String duration;
  final String kcal;
  final int index;

  ActivityItem({
    Key? key,
    this.icon,
    // this.emoji,
    required this.name,
    required this.index,
    required this.duration,
    required this.kcal,
  }) : super(key: key);

  var controller = Get.find<ActivityLogController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(icon, size: 30)
          : Text(
              '',
              style: const TextStyle(fontSize: 30),
            ),
      title: Text(name),
      subtitle: Text(duration),
      trailing: Text(kcal),
      onTap: () {
        controller.goToUpdateActivityLog(index);
      },
    );
  }
}
