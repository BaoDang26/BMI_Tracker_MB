import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../controllers/meal_details_controller.dart';
import '../../../util/app_export.dart';
import 'meal_log_item.dart';

class MealLogView extends StatefulWidget {
  const MealLogView({super.key});

  @override
  State<MealLogView> createState() => _MealLogViewState();
}

class _MealLogViewState extends State<MealLogView> {
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.mealLogModels.length,
        itemBuilder: (context, index) {
          var mealLog = controller.mealLogModels[index];
          return Slidable(
            key: Key(mealLog.mealLogID.toString()),
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  controller.goToUpdateMealLog(index);
                },
                backgroundColor: const Color(0xFF1FBE1B),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (context) {
                  controller.removeMealLog(index);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
            child: MealLogItem(
              name: mealLog.foodName ?? "Honey",
              // description: '1 tbsp. (21 g)',
              kcal: mealLog.calories.toString(),
            ),
          );
        },
      ),
    );
  }
}
