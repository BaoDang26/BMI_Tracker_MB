import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../../widgets/widgets.dart';

class RegisterComplete extends StatelessWidget {
  const RegisterComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "All Set!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Please verify your account! Enjoy your meal!",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomElevatedButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.loginScreen);
            },
            text: 'Continue'),
      ),
    );
  }
}
