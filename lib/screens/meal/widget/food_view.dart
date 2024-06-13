import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:get/get.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.foodModels.length,

        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${controller.foodModels[index].foodName}"),
            subtitle: Text("${controller.foodModels[index].description}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${controller.foodModels[index].foodCalories} kcal'),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.blue),
                  onPressed: () {
                    // Handle add button press
                    controller
                        .createMealLogByFood(controller.foodModels[index]);
                  },
                ),
              ],
            ),
            onTap: () {
              controller.goToFoodDetails(controller.foodModels[index]);
            },
          );
        },
      ),
    );
  }
}
