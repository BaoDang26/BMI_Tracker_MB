import 'package:flutter/material.dart';
import 'package:flutter_health_menu/config/theme.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:flutter_health_menu/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_health_menu/screens/profile/profile_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const LoginScreen(),
    );
  }
}
