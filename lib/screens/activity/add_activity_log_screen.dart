import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_details_controller.dart';
import 'package:flutter_health_menu/widgets/custom_elevated_button.dart';
import 'package:flutter_health_menu/widgets/entry_filed.dart';

import '../../util/app_export.dart';

class AddActivityLogScreen extends StatefulWidget {
  const AddActivityLogScreen({super.key});

  @override
  State<AddActivityLogScreen> createState() => _AddActivityLogScreenState();
}

class _AddActivityLogScreenState extends State<AddActivityLogScreen> {
  var controller = Get.find<ActivityDetailsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Custom Activity',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30.adaptSize,
                        child: const Icon(Icons.directions_run_outlined,
                            color: Colors.blue),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '0 kcal',
                        style: TextStyle(
                            fontSize: 18.fSize, fontWeight: FontWeight.bold),
                      ),
                      EntryField(
                        label: 'Activity name',
                        placeholder: 'name',
                        controller: controller.activityNameEditController,
                      ),
                      EntryField(
                        label: 'Calories Burned',
                        placeholder: 'calories burned (kcal)',
                        controller: controller.caloriesBurnedEditController,
                      ),
                      EntryField(
                        label: 'Duration',
                        placeholder: 'duration (min)',
                        controller: controller.durationEditController,
                      ),
                      Center(
                        child: CustomElevatedButton(
                            onPressed: () {
                              controller.createActivityLogByForm();
                            },
                            text: "Add"),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
