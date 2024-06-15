import 'package:flutter/material.dart';

import '../../../controllers/activity_details_controller.dart';
import '../../../util/app_export.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  var controller = Get.find<ActivityDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.workoutModels.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.workoutModels.isEmpty
                  ? Container(
                      height: 200.v,
                      color: Colors.orange,
                    )
                  : ListTile(
                      leading: Text(
                        controller.workoutModels[index].emoji ?? '',
                        style: TextStyle(fontSize: 30.fSize),
                      ),
                      title: Text(
                          '${controller.workoutModels[index].exerciseName}'),
                      subtitle:
                          Text('${controller.workoutModels[index].duration}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              '${controller.workoutModels[index].caloriesBurned} kcal'),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline,
                                color: Colors.lightGreen),
                            onPressed: () {
                              // Handle add button press
                              controller.createActivityLogByExercise(
                                  controller.workoutModels[index]);
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
