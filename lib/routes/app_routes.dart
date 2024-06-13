import 'package:flutter_health_menu/binding/activity_binding.dart';
import 'package:flutter_health_menu/binding/advisor_binding.dart';
import 'package:flutter_health_menu/binding/advisor_details_binding.dart';
import 'package:flutter_health_menu/binding/bottom_nav_binding.dart';
import 'package:flutter_health_menu/binding/forgot_password_binding.dart';
import 'package:flutter_health_menu/binding/home_binding.dart';
import 'package:flutter_health_menu/binding/login_binding.dart';
import 'package:flutter_health_menu/binding/mea_details_binding.dart';
import 'package:flutter_health_menu/binding/plan_binding.dart';
import 'package:flutter_health_menu/binding/profile_binding.dart';
import 'package:flutter_health_menu/binding/register_in_binding.dart';
import 'package:flutter_health_menu/binding/register_member.binding.dart';
import 'package:flutter_health_menu/screens/activity/activity_log_details_screen.dart';
import 'package:flutter_health_menu/screens/advisor/advisor_details_screen.dart';
import 'package:flutter_health_menu/screens/advisor/advisor_screen.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/screens/forget_password/forget_password_screen.dart';
import 'package:flutter_health_menu/screens/home/home_screen.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:flutter_health_menu/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_health_menu/screens/plan/plan_package_screen.dart';
import 'package:flutter_health_menu/screens/profile/profile_screen.dart';
import 'package:flutter_health_menu/screens/register/register_in_screen.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:get/get.dart';

import '../binding/onboarding_binding.dart';
import '../screens/meal/meal_details_screen.dart';

class AppRoutes {
  static const String loginScreen = '/loginScreen';
  static const String bottomNavScreen = '/bottomNavScreen';
  static const String advisorScreen = '/advisorScreen';
  static const String profileScreen = '/profileScreen';
  static const String registerMemberScreen = '/registerMemberScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String registerScreen = '/registerScreen';
  static const String homeScreen = '/homeScreen';
  static const String mealDetailsScreen = '/mealDetailsScreen';
  static const String activityDetailsScreen = '/activityDetailsScreen';
  static const String advisorDetailsScreen = '/advisorDetailsScreen';
  static const String planScreen = '/planScreen';

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
      name: advisorScreen,
      page: () => const AdvisorScreen(),
      bindings: [
        AdvisorBinding(),
      ],
    ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
      bindings: [
        ProfileBinding(),
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
        RegisterInBinding(),
      ],
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: mealDetailsScreen,
      page: () => MealDetailsScreen(),
      bindings: [
        MealDetailsBinding(),
      ],
    ),
    GetPage(
      name: activityDetailsScreen,
      page: () => ActivityDetailsScreen(),
      bindings: [
        ActivityBinding(),
      ],
    ),
    GetPage(
      name: advisorDetailsScreen,
      page: () => AdvisorDetailsScreen(),
      bindings: [
        AdvisorDetailsBinding(),
      ],
    ),
    GetPage(
      name: planScreen,
      page: () => PlanPackageScreen(),
      bindings: [
        PlanBinding(),
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