import 'package:flutter/material.dart';

import '../../../controllers/activity_details_controller.dart';
import '../../../util/app_export.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  var controller = Get.find<ActivityDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ListView.builder(
          itemCount: controller.exerciseModels.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.exerciseModels.isEmpty
                  ? Container(
                height: 200,
                color: Colors.orange,
              )
                  : ListTile(
                leading: Text(
                  controller.exerciseModels[index].emoji ?? '',
                  style: const TextStyle(fontSize: 30),
                ),
                title: Text(
                    '${controller.exerciseModels[index].exerciseName}'),
                subtitle:
                Text('${controller.exerciseModels[index].duration}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        '${controller.exerciseModels[index].caloriesBurned} kcal'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.lightGreen),
                      onPressed: () {
                        // Handle add button press
                        controller.createActivityLogByExercise(
                            controller.exerciseModels[index]);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // Add tile tap functionality here
                },
              ),
            );
          }),
    );
  }
}
