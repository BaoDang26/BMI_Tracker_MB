import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';

 import '../../../util/app_export.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  var controller = Get.find<ActivityLogController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.workoutExerciseModels.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.workoutExerciseModels.isEmpty
                  ? Container(
                      height: 200.v,
                      color: Colors.orange,
                    )
                  : ListTile(
                      leading: Text(
                        controller.workoutExerciseModels[index].emoji ?? '🎽',
                        style: TextStyle(fontSize: 30.fSize),
                      ),
                      title: Text(
                          '${controller.workoutExerciseModels[index].exerciseName}'),
                      subtitle: Text(
                          '${controller.workoutExerciseModels[index].duration} min'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.h),
                            child: Text(
                                '${controller.workoutExerciseModels[index].caloriesBurned} kcal'),
                          ),
                          AsyncButtonBuilder(
                            loadingWidget: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ),
                            successWidget: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.check,
                                color: Colors.lightGreen,
                              ),
                            ),
                            onPressed: () async {
                              await Future.delayed(const Duration(seconds: 1));
                              controller.createActivityLogByWorkoutExercise(
                                  controller.workoutExerciseModels[index]);
                            },
                            loadingSwitchInCurve: Curves.bounceInOut,
                            loadingTransitionBuilder: (child, animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1.0),
                                  end: const Offset(0, 0),
                                ).animate(animation),
                                child: child,
                              );
                            },
                            builder: (context, child, callback, state) {
                              return Material(
                                color: state.maybeWhen(
                                  success: () => Colors.green[100],
                                  orElse: () => Colors.lightGreen,
                                ),
                                // This prevents the loading indicator showing below the
                                // button
                                clipBehavior: Clip.hardEdge,
                                shape: const StadiumBorder(),
                                child: InkWell(
                                  onTap: callback,
                                  child: child,
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.white,
                              child: Icon(Icons.add_circle_outline,
                                  color: Colors.lightGreen, size: 30.adaptSize),
                            ),
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
