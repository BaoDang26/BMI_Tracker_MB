import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/screens/meal/widget/meal_log_view.dart';
import 'package:flutter_health_menu/screens/meal/widget/menu_view.dart';
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
              controller.gotoAddMealLog();
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     CircleAvatar(
            //       backgroundColor: Colors.blue,
            //       child: Icon(Icons.search, color: Colors.white),
            //     ),
            //     SizedBox(width: 10),
            //     Expanded(
            //       child: TextField(
            //         decoration: InputDecoration(
            //           hintText: 'What are you looking for?',
            //           prefixIcon: Icon(Icons.search),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(16),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
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
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        MenuView(),
                        MealLogView(),
                        Center(child: Text('Foods')),
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

// class CategoryButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//
//   CategoryButton({required this.icon, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           child: Icon(icon, size: 30),
//         ),
//         SizedBox(height: 8),
//         Text(label),
//       ],
//     );
//   }
// }
