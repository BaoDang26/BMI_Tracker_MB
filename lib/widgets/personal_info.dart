import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:get/get.dart';


class PersonalInfo extends StatelessWidget {
  final int height;
  final int weight;
  final int age;
  final homeController = Get.put(HomePageController());

  PersonalInfo({
    Key? key,
    required this.height,
    required this.weight,
    required this.age,
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
                Icons.emoji_people_outlined,
                color: Colors.white,
              ),
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Text(
                  'AGE',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Obx(() => Text('${homeController.currentMember.value.age}')),
                // Text('23'),
              ],
            )
          ],
        ),
      ],
    );
  }
}
