import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_elevated_button.dart';

class ForgotPasswordComplete extends StatelessWidget {
  const ForgotPasswordComplete({super.key});

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
              "Please relogin your account! Enjoy your meal!",
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
