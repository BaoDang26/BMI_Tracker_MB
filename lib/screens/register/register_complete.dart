import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';

import '../../widgets/widgets.dart';

class RegisterComplete extends StatelessWidget {
  const RegisterComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                child: Column(
                  children: [
                    Text(
                      "All Set!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "You are ready to go! Enjoy your meal!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomElevatedButton(
            onPressed: () {
              //TODO: register CometChat User here

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
            text: 'Continue'),
      ),
    );
  }
}
