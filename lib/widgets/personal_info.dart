import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/theme/theme_helper.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

class PersonalInfo extends StatelessWidget {
  final homeController = Get.put(HomePageController());

  PersonalInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.height,
                color: Colors.white,
              ),
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Text(
                  'HEIGHT',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Obx(() =>
                    Text('${homeController.currentMember.value.height} cm')),
                // Text('170 cm'),
              ],
            )
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.line_weight_rounded,
                color: Colors.white,
              ),
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Text(
                  'WEIGHT',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Obx(() =>
                    Text('${homeController.currentMember.value.weight} kg')),
                // Text('65 kg'),
              ],
            )
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.monitor_weight,
                color: Colors.white,
              ),
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Text(
                  'TARGET WEIGHT',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Obx(() => Text(
                    '${homeController.currentMember.value.targetWeight} kg')),
                // Text('65 kg'),
              ],
            )
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.emoji_people_outlined,
                color: Colors.white,
              ),
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'BMI',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Obx(() {
                      if (homeController.currentMember.value.bmi! < 16) {
                        return Tooltip(
                          message: "Body mass deficit",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(Icons.warning,
                              color: appTheme.red500, size: 18.adaptSize),
                        );
                      } else if (homeController.currentMember.value.bmi! >=
                          30) {
                        return Tooltip(
                          message: "Obesity degree",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(Icons.warning,
                              color: appTheme.red500, size: 18.adaptSize),
                        );
                      } else if (homeController.currentMember.value.bmi! >=
                              16 &&
                          homeController.currentMember.value.bmi! < 18.5) {
                        return Tooltip(
                          message: "Body weight deficit",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(Icons.warning,
                              color: appTheme.yellow500, size: 18.adaptSize),
                        );
                      } else if (homeController.currentMember.value.bmi! >=
                              25 &&
                          homeController.currentMember.value.bmi! < 30) {
                        return Tooltip(
                          message: "Weight over",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(Icons.warning,
                              color: appTheme.yellow500, size: 18.adaptSize),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                  ],
                ),
                Obx(() =>
                    Text('${homeController.currentMember.value.bmi?.round()}')),
              ],
            )
          ],
        ),
      ],
    );
  }
}
