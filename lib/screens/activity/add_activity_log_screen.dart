import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';
import 'package:flutter_health_menu/widgets/custom_elevated_button.dart';
import 'package:flutter_health_menu/widgets/entry_filed.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../util/app_export.dart';

class AddActivityLogScreen extends StatefulWidget {
  const AddActivityLogScreen({super.key});

  @override
  State<AddActivityLogScreen> createState() => _AddActivityLogScreenState();
}

class _AddActivityLogScreenState extends State<AddActivityLogScreen> {
  var controller = Get.find<ActivityLogController>();

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
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Custom Exercise',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.activityLogFormKey,
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
                                fontSize: 18.fSize,
                                fontWeight: FontWeight.bold),
                          ),
                          EntryField(
                            validator: (value) {
                              return controller.validateExerciseName(value!);
                            },
                            label: 'Exercise name',
                            placeholder: 'Enter exercise name',
                            textInputType: TextInputType.text,
                            controller:
                                controller.txtActivityNameEditController,
                          ),
                          EntryField(
                            validator: (value) {
                              return controller.validateCalories(value!);
                            },
                            label: 'Calories Burned (kcal)',
                            placeholder: 'calories burned',
                            textInputType: TextInputType.number,
                            controller:
                                controller.txtCaloriesBurnedEditController,
                          ),
                          EntryField(
                            controller: controller.txtDurationEditController,
                            validator: (value) {
                              return controller.validateDuration(value!);
                            },
                            label: 'Duration (min)',
                            placeholder: 'Enter duration',
                            textInputType: TextInputType.number,
                          ),
                          Center(
                            child: CustomElevatedButton(
                                onPressed: () {
                                  final isValid = controller
                                      .activityLogFormKey.currentState!
                                      .validate();
                                  if (!isValid) {
                                    return;
                                  }
                                  controller.activityLogFormKey.currentState!
                                      .save();
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
        ),
      );
    });
  }
}
