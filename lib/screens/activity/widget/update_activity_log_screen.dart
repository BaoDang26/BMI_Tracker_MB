import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';
import 'package:flutter_health_menu/widgets/custom_elevated_button.dart';
import 'package:flutter_health_menu/widgets/entry_filed.dart';

import '../../../util/app_export.dart';

class UpdateActivityLogScreen extends StatelessWidget {
  int index;

  UpdateActivityLogScreen(this.index, {super.key});

  var controller = Get.find<ActivityLogController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Activity',
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
                        '${controller.txtCaloriesBurnedEditController.text} kcal',
                        style: TextStyle(
                            fontSize: 18.fSize, fontWeight: FontWeight.bold),
                      ),
                      EntryField(
                        label: 'Activity name',
                        placeholder: 'name',
                        textInputType: TextInputType.text,
                        controller: controller.txtActivityNameEditController,
                      ),
                      EntryField(
                        label: 'Calories Burned (kcal)',
                        placeholder: 'calories burned',
                        textInputType: TextInputType.number,
                        controller: controller.txtCaloriesBurnedEditController,
                      ),
                      EntryField(
                        label: 'Duration (min)',
                        placeholder: 'duration',
                        textInputType: TextInputType.number,
                        controller: controller.txtDurationEditController,
                      ),
                      Center(
                        child: CustomElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await controller.updateActivityLog(index);
                            Get.back();
                          },
                          text: "Update",
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
