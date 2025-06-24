import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class MealLogItem extends StatelessWidget {
  final String name;

  final String description;
  final String kcal;
  final int index;

  MealLogItem(
      {super.key,
      required this.name,
      required this.index,
      required this.description,
      required this.kcal});

  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(description),
      trailing: Text('$kcal kcal', style: TextStyle(fontSize: 15.fSize)),
      onTap: () {
        controller.goToUpdateMealLog(index);
      },
    );
  }
}
