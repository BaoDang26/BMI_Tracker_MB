import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';
import 'package:flutter_health_menu/screens/activity/widget/activity_view.dart';
import 'package:flutter_health_menu/screens/activity/widget/exercise_view.dart';
import 'package:flutter_health_menu/screens/activity/widget/workout_view.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class ActivityDetailsScreen extends GetView<ActivityLogController> {
  const ActivityDetailsScreen({super.key});

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
        appBar: AppBar(
          title: Obx(
            () => Column(
              children: [
                const Text(
                  'Workout',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  controller.dateActivity.value,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20.h),
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    controller.goToAddActivityLog();
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            )

            // PopupMenuButton<String>(
            //   color: Colors.white,
            //   onSelected: (String result) {
            //     // Xử lý khi chọn một item trong menu
            //     controller.selectAction(result);
            //   },
            //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            //     const PopupMenuItem<String>(
            //       value: 'Custom entry activity',
            //       child: Text('Custom entry activity'),
            //     ),
            //     const PopupMenuItem<String>(
            //       value: 'Chart',
            //       child: Text('View statistics calories'),
            //     ),
            //   ],
            // ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Obx(() {
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
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  physics: NeverScrollableScrollPhysics(),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.ac_unit),
                      text: "Exercises",
                    ),
                    Tab(
                      icon: Icon(Icons.traffic_sharp),
                      text: "Advisor's Workout",
                    ),
                    Tab(icon: Icon(Icons.history), text: "Recent"),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5.h),
                  height: 590.h,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const ExerciseView(),
                      Obx(() {
                        if (controller.workoutExerciseModels.isEmpty) {
                          return Center(
                              child: Text(
                            'Empty workout',
                            style: TextStyle(fontSize: 16.fSize),
                          ));
                        } else {
                          return const WorkoutView();
                        }
                      }),
                      Obx(() {
                        if (controller.activityLogModels.isEmpty) {
                          return Center(
                              child: Text(
                            'Empty Exercises Logs',
                            style: TextStyle(fontSize: 16.fSize),
                          ));
                        } else {
                          return ActivityLogView();
                        }
                      }),
                      // Center(child: Text('Favorites')),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
