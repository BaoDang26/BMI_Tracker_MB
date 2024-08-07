import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/screens/meal/widget/food_view.dart';
import 'package:flutter_health_menu/screens/meal/widget/meal_log_view.dart';
import 'package:flutter_health_menu/screens/meal/widget/menu_view.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class MealDetailsScreen extends GetView<MealDetailsController> {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.mealType.value.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {
          //     controller.goToSearchFood();
          //   },
          // ),
          Container(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              child: IconButton(
                onPressed: () {
                  controller.goToAddMealLog();
                },
                icon: const Icon(Icons.add),
              ),
            ),
          )
          // PopupMenuButton<String>(
          //   color: Colors.white,
          //   onSelected: (String result) {
          //     // Xử lý khi chọn một item trong menu
          //     controller.selectAction(result);
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //     const PopupMenuItem<String>(
          //       value: 'Custom entry meal',
          //       child: Text('Custom entry meal'),
          //     ),
          //     const PopupMenuItem<String>(
          //       value: 'Chart',
          //       child: Text('View statistics calories'),
          //     ),
          //   ],
          // ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Column(
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
                          icon: Icon(Icons.food_bank),
                          text: "Foods",
                        ),
                        Tab(
                          icon: Icon(Icons.menu),
                          text: "Advisor's Menu",
                        ),
                        Tab(icon: Icon(Icons.history), text: "Recent"),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5.h),
                      height: 590.h,
                      // width: 50.v,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const FoodView(),
                          const MenuView(),
                          Obx(() {
                            if (controller.mealLogModels.isEmpty) {
                              return Center(
                                  child: Text(
                                'No Entries in Meal Logs',
                                style: TextStyle(fontSize: 16.fSize),
                              ));
                            } else {
                              return const MealLogView();
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
