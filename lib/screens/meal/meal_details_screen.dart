import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/screens/meal/widget/food_view.dart';
import 'package:flutter_health_menu/screens/meal/widget/meal_log_view.dart';
import 'package:flutter_health_menu/screens/meal/widget/menu_view.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

class MealDetailsScreen extends GetView<MealDetailsController> {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.mealType.value.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.blue),
            onPressed: () {
              controller.goToAddMealLog();
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    physics: NeverScrollableScrollPhysics(),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.menu),
                        text: "Menu",
                      ),
                      Tab(icon: Icon(Icons.history), text: "Recent"),
                      Tab(
                        icon: Icon(Icons.food_bank),
                        text: "Foods",
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5.h),
                    height: 600.h,
                     child: const TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        MenuView(),
                        MealLogView(),
                        FoodView(),
                        // Center(child: Text('Favorites')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
