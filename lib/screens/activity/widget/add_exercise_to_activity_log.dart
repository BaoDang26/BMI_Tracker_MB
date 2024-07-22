import 'package:flutter/material.dart';
import 'package:flutter_health_menu/widgets/custom_elevated_button2.dart';

import '../../../controllers/activity_log_controller.dart';
import '../../../util/app_export.dart';

class AddExerciseToActivityLog extends GetView<ActivityLogController> {
  AddExerciseToActivityLog(this.index, {super.key});

  int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add activity log",
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
                        '${controller.caloriesBurnedEditController.text} kcal',
                        style: TextStyle(
                            fontSize: 18.fSize, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.v),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Activity name"),
                          ),
                          enabled: false,
                          controller: controller.activityNameEditController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.v),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Calories burned (kcal)"),
                          ),
                          enabled: false,
                          controller: controller.caloriesBurnedEditController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 15.v),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10.v),
                              child: const Text("Duration (min)"),
                            ),
                            TextField(
                              onChanged: (value) {
                                controller.onChangeDuration(value, index);
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(hintText: "Duration"),
                              controller: controller.durationEditController,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Obx(
                          () => CustomElevatedButton(
                            onPressed: () {
                              controller.createActivityLog(index);
                            },
                            isDisabled:
                                controller.isButtonDisable.value ? true : false,
                            buttonStyle: ButtonStyle(
                              backgroundColor: controller.isButtonDisable.value
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.black12)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.green),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                            text: "Add",
                          ),
                        ),
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
