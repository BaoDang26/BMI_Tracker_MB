import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../models/user_model.dart';

class PersonalInfo extends StatelessWidget {
  final int height;
  final int weight;
  final int age;
  const PersonalInfo({
    Key? key,
    required this.height,
    required this.weight,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    UserModel currentUser = loginController.loginedUser.value;
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
                Text('${currentUser.userbodymaxs?.heght} cm'),
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
                Text('${currentUser.userbodymaxs?.weight} kg'),
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
                Text('${currentUser.userbodymaxs?.age}'),
              ],
            )
          ],
        ),
      ],
    );
  }
}
