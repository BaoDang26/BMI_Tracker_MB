import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:get/get.dart';

class MealDetailsScreen extends StatelessWidget {
  MealDetailsScreen({super.key});

  final mealDetailsController = Get.put(MealDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breakfast',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.blue),
            onPressed: () {
              // More button functionality
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton(icon: Icons.food_bank, label: 'Foods'),
                CategoryButton(icon: Icons.restaurant_menu, label: 'Meals'),
                CategoryButton(icon: Icons.access_alarm, label: 'Recipes'),
              ],
            ),
            SizedBox(height: 16),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Frequent'),
                      Tab(text: 'Recent'),
                      // Tab(text: 'Favorites'),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      children: [
                        FoodListView(),
                        Center(child: Text('Recent')),
                        // Center(child: Text('Favorites')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Done button functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(icon, size: 30),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FoodItem(
          name: 'Honey',
          description: '1 tbsp. (21 g)',
          kcal: '64 kcal',
        ),
        FoodItem(
          name: 'Banana',
          description: '1 whole, regular (150 g)',
          kcal: '134 kcal',
        ),
        FoodItem(
          name: 'Egg, boiled',
          description: '1 egg, regular (60 g)',
          kcal: '93 kcal',
        ),
      ],
    );
  }
}

class FoodItem extends StatelessWidget {
  final String name;
  final String description;
  final String kcal;

  FoodItem({required this.name, required this.description, required this.kcal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(description),
      trailing: Text(kcal),
      onTap: () {
        // Add button functionality
      },
    );
  }
}
