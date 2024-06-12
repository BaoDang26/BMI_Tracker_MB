import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/activity/widget/activity_view.dart';
import 'package:flutter_health_menu/screens/activity/widget/workout_view.dart';
import 'package:flutter_health_menu/screens/meal/widget/meal_log_view.dart';
import 'package:get/get.dart';

import '../../controllers/activity_details_controller.dart';

class ActivityDetailsScreen extends GetView<ActivityDetailsController> {
  ActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     controller.getBack();
        //   },
        // ),
        title: const Text(
          'Activities',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          // biểu đồ
          IconButton(
            icon: const Icon(Icons.show_chart, color: Colors.blue),
            onPressed: () {
              // Add chart button functionality here
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              physics: NeverScrollableScrollPhysics(),
              tabs: [
                Tab(
                  icon: Icon(Icons.traffic_sharp),
                  text: "Workout",
                ),
                Tab(icon: Icon(Icons.history), text: "Activity log"),
                Tab(
                  icon: Icon(Icons.ac_unit),
                  text: "Exercises",
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // MenuView(),
                  // MealLogView(),
                  WorkoutView(),
                  ActivityLogView(),
                  Center(child: Text('Foods')),
                  // Center(child: Text('Favorites')),
                ],
              ),
            ),
          ],
        ),
      ),

      // Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Activities',
      //         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
      //               fontSize: 20,
      //               color: Colors.black,
      //             ),
      //       ),
      //       const SizedBox(height: 10),
      //       Expanded(
      //         child: Obx(
      //           () => ListView.builder(
      //               shrinkWrap: true,
      //               itemCount: controller.exerciseLogModel.length,
      //               scrollDirection: Axis.vertical,
      //               itemBuilder: (context, index) {
      //                 return Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: controller.exerciseLogModel.isEmpty
      //                       ? Container(
      //                           // height: 2,
      //                           color: Colors.red,
      //                         )
      //                       : ActivityTile(
      //                           emoji: controller.exerciseLogModel[index].emoji,
      //                           name:
      //                               "${controller.exerciseLogModel[index].activityName} ",
      //                           duration:
      //                               "${controller.exerciseLogModel[index].duration} min",
      //                           kcal:
      //                               "${controller.exerciseLogModel[index].caloriesBurned} kcal"),
      //                 );
      //               }),
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       Center(
      //         child: ElevatedButton(
      //           onPressed: () {
      //             // Add more button functionality here
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.blue,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(16),
      //             ),
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      //           ),
      //           child: const Text(
      //             'Add more',
      //             style: TextStyle(color: Colors.white, fontSize: 16),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
