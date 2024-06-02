import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/activity_details_controller.dart';

class ActivityDetailsScreen extends StatelessWidget {
  ActivityDetailsScreen({super.key});

  final controller = Get.put(ActivityDetailsController());

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activities',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.exerciseLogModel.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: controller.exerciseLogModel.isEmpty
                            ? Container(
                                // height: 2,
                                color: Colors.red,
                              )
                            : ActivityTile(
                                emoji: controller.exerciseLogModel[index].emoji,
                                name:
                                    "${controller.exerciseLogModel[index].activityName} ",
                                duration:
                                    "${controller.exerciseLogModel[index].duration} min",
                                kcal:
                                    "${controller.exerciseLogModel[index].caloriesBurned} kcal"),
                      );
                    }),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add more button functionality here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Add more',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String name;
  final String duration;
  final String kcal;

  const ActivityTile({
    Key? key,
    this.icon,
    this.emoji,
    required this.name,
    required this.duration,
    required this.kcal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(icon, size: 30)
          : Text(
              emoji ?? '',
              style: const TextStyle(fontSize: 30),
            ),
      title: Text(name),
      subtitle: Text(duration),
      trailing: Text(kcal),
      onTap: () {
        // Add tile tap functionality here
      },
    );
  }
}
