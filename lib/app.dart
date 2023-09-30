import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/config/theme.dart';
import 'package:flutter_health_menu/screens/onboarding/onboarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: const OnboardingScreen(),
    );
  }
}
