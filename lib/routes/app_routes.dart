import 'package:flutter_health_menu/binding/bottom_nav_binding.dart';
import 'package:flutter_health_menu/binding/forgot_password_binding.dart';
import 'package:flutter_health_menu/binding/login_binding.dart';
import 'package:flutter_health_menu/binding/register_member.binding.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/screens/forget_password/forget_password_screen.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:flutter_health_menu/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_health_menu/screens/register/register_in_screen.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:get/get.dart';

import '../binding/onboarding_binding.dart';

class AppRoutes {
  static const String loginScreen = '/loginScreen';
  static const String bottomNavScreen = '/bottomNavScreen';
  static const String registerMemberScreen = '/registerMemberScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String registerScreen = '/registerScreen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: bottomNavScreen,
      page: () => const BottomNavScreen(),
      bindings: [
        BottomNavBinding(),
      ],
    ),
    GetPage(
      name: registerMemberScreen,
      page: () => const RegisterInFoScreen(),
      bindings: [
        RegisterMemberBinding(),
      ],
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
      ],
    ),
    GetPage(
      name: registerScreen,
      page: () => const RegisterInScreen(),
      bindings: [
        // RegisterMemberBinding(),
      ],
    ),


    GetPage(
      name: initialRoute,
      page: () => const OnboardingScreen(),
      bindings: [
        OnboardingBinding(),
      ],
    ),
  ];
}
