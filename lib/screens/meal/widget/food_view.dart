import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/food_model.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FoodModel>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<FoodModel>(
        itemBuilder: (context, foodModel, index) {
          return ListTile(
            title: Text(foodModel.foodName!),
            subtitle: Text(foodModel.description!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${foodModel.foodCalories} kcal',
                    style: TextStyle(fontSize: 15.fSize)),
                IconButton(
                  icon:
                      Icon(Icons.add_circle_outline, color: Colors.lightGreen),
                  onPressed: () {
                    // Handle add button press
                    controller.createMealLogByFood(foodModel);
                  },
                ),
              ],
            ),
            onTap: () {
              controller.goToFoodDetails(foodModel);
            },
          );
        },
        firstPageErrorIndicatorBuilder: (context) => Center(
          child: Text('Error loading first page'),
        ),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text('No items found'),
        ),
      ),
    );
  }
}
