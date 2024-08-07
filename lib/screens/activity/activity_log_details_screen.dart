import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/activity/widget/activity_view.dart';
import 'package:flutter_health_menu/screens/activity/widget/exercise_view.dart';
import 'package:flutter_health_menu/screens/activity/widget/workout_view.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

import '../../controllers/activity_details_controller.dart';

class ActivityDetailsScreen extends GetView<ActivityDetailsController> {
  const ActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activities',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (String result) {
              // Xử lý khi chọn một item trong menu
              controller.selectAction(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Custom entry activity',
                child: Text('Custom entry activity'),
              ),
              const PopupMenuItem<String>(
                value: 'Chart',
                child: Text('View statistics calories'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
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
                    text: "Workout",
                  ),
                  Tab(icon: Icon(Icons.history), text: "Activity log"),
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5.h),
                height: 590.h,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ExerciseView(),
                    const WorkoutView(),
                    Obx(() {
                      if (controller.activityLogModels.isEmpty) {
                        return Center(
                            child: Text(
                          'No Activity Logs',
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
  }
}
