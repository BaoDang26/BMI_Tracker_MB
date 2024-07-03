import 'package:flutter_health_menu/binding/activity_binding.dart';
import 'package:flutter_health_menu/binding/advisor_binding.dart';
import 'package:flutter_health_menu/binding/advisor_booking_details_binding.dart';
import 'package:flutter_health_menu/binding/advisor_details_binding.dart';
import 'package:flutter_health_menu/binding/blog_binding.dart';
import 'package:flutter_health_menu/binding/booking_details_binding.dart';
import 'package:flutter_health_menu/binding/booking_history_binding.dart';
import 'package:flutter_health_menu/binding/bottom_nav_binding.dart';
import 'package:flutter_health_menu/binding/feedback_binding.dart';
import 'package:flutter_health_menu/binding/food_details_binding.dart';
import 'package:flutter_health_menu/binding/forgot_password_binding.dart';
import 'package:flutter_health_menu/binding/home_binding.dart';
import 'package:flutter_health_menu/binding/login_binding.dart';
import 'package:flutter_health_menu/binding/meal_details_binding.dart';
import 'package:flutter_health_menu/binding/meal_log_food_details_binding.dart';
import 'package:flutter_health_menu/binding/payment_binding.dart';
import 'package:flutter_health_menu/binding/plan_binding.dart';
import 'package:flutter_health_menu/binding/profile_binding.dart';
import 'package:flutter_health_menu/binding/register_in_binding.dart';
import 'package:flutter_health_menu/binding/register_member.binding.dart';
import 'package:flutter_health_menu/binding/statistics_calories_binding.dart';
import 'package:flutter_health_menu/binding/tracking_weight_binding.dart';
import 'package:flutter_health_menu/binding/update_profile_binding.dart';
import 'package:flutter_health_menu/screens/activity/activity_log_details_screen.dart';
import 'package:flutter_health_menu/screens/advisor/blog_details_screen.dart';
import 'package:flutter_health_menu/screens/advisor/blog_screen.dart';
import 'package:flutter_health_menu/screens/advisor_booking_details/advisor_booking_details.dart';
import 'package:flutter_health_menu/screens/booking/booking_history_screen.dart';
import 'package:flutter_health_menu/screens/booking_details/booking_details_screen.dart';
import 'package:flutter_health_menu/screens/home/statistics_calories_screen.dart';
import 'package:flutter_health_menu/screens/meal_log_food_details_screen/meal_log_food_details_screen.dart';
import 'package:flutter_health_menu/screens/payment/payment_screen.dart';
import 'package:flutter_health_menu/screens/plan/plan_package_screen.dart';
import 'package:flutter_health_menu/screens/register/register_in_screen.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:flutter_health_menu/screens/screens.dart';
import 'package:flutter_health_menu/screens/tracking_weight/tracking_weight_screen.dart';
import 'package:get/get.dart';

import '../binding/notification_binding.dart';
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
  static const String mealLogFoodDetailsScreen = '/mealLogFoodDetailsScreen';
  static const String activityDetailsScreen = '/activityDetailsScreen';
  static const String advisorDetailsScreen = '/advisorDetailsScreen';
  static const String advisorBookingDetailsScreen =
      '/advisorBookingDetailsScreen';
  static const String planScreen = '/planScreen';
  static const String blogDetailsScreen = '/blogDetailsScreen';
  static const String blogScreen = '/blogScreen';
  static const String paymentScreen = '/paymentScreen';
  static const String foodDetailsScreen = '/foodDetailsScreen';
  static const String trackingWeightScreen = '/trackingWeightScreen';
  static const String statisticsCaloriesScreen = '/statisticsCaloriesScreen';
  static const String bookingHistoryScreen = '/bookingHistoryScreen';
  static const String bookingDetailsScreen = '/bookingDetailsScreen';
  static const String feedbackScreen = '/feedbackScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String updateProfileScreen = '/updateProfileScreen';

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
      name: advisorBookingDetailsScreen,
      page: () => AdvisorBookingDetailsScreen(),
      bindings: [
        AdvisorBookingDetailsBinding(),
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
      page: () => const MealDetailsScreen(),
      bindings: [
        MealDetailsBinding(),
      ],
    ),
    GetPage(
      name: mealLogFoodDetailsScreen,
      page: () => const MealLogFoodDetailsScreen(),
      bindings: [
        MealLogFoodDetailsBinding(),
      ],
    ),
    GetPage(
      name: activityDetailsScreen,
      page: () => const ActivityDetailsScreen(),
      bindings: [
        ActivityBinding(),
      ],
    ),
    GetPage(
      name: advisorDetailsScreen,
      page: () => const AdvisorDetailsScreen(),
      bindings: [
        AdvisorDetailsBinding(),
      ],
    ),
    GetPage(
      name: planScreen,
      page: () => const PlanPackageScreen(),
      bindings: [
        PlanBinding(),
      ],
    ),
    GetPage(
      name: blogScreen,
      page: () => const BlogScreen(),
      bindings: [
        BlogBinding(),
      ],
    ),
    GetPage(
      name: blogDetailsScreen,
      page: () => const BlogDetailScreen(),
      bindings: const [
        // BlogBinding(),
      ],
    ),
    GetPage(
      name: paymentScreen,
      page: () => const PaymentScreen(),
      bindings: [
        PaymentBindings(),
      ],
    ),
    GetPage(
      name: foodDetailsScreen,
      page: () => const FoodDetailScreen(),
      bindings: [
        FoodDetailsBinding(),
      ],
    ),
    GetPage(
      name: trackingWeightScreen,
      page: () => TrackingWeightScreen(),
      bindings: [
        TrackingWeightBinding(),
      ],
    ),
    GetPage(
      name: statisticsCaloriesScreen,
      page: () => StatisticsCaloriesScreen(),
      bindings: [
        StatisticsCaloriesBinding(),
      ],
    ),
    GetPage(
      name: bookingHistoryScreen,
      page: () => const BookingHistoryScreen(),
      bindings: [
        BookingHistoryBinding(),
      ],
    ),
    GetPage(
      name: bookingDetailsScreen,
      page: () => const BookingDetailsScreen(),
      bindings: [
        BookingDetailsBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => const OnboardingScreen(),
      bindings: [
        OnboardingBinding(),
      ],
    ),
    GetPage(
      name: feedbackScreen,
      page: () => const FeedbackScreen(),
      bindings: [
        FeedbackBinding(),
      ],
    ),
    GetPage(
      name: notificationScreen,
      page: () => const NotificationScreen(),
      bindings: [
        NotificationBinding(),
      ],
    ),
    GetPage(
      name: updateProfileScreen,
      page: () => const UpdateProfileScreen(),
      bindings: [
        UpdateProfileBinding(),
      ],
    ),
  ];
}
