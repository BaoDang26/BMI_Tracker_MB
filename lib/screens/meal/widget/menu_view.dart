import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.foodMenuModels.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${controller.foodMenuModels[index].foodName}"),
            subtitle: Text("${controller.foodMenuModels[index].description}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${controller.foodMenuModels[index].foodCalories} kcal',
                    style: TextStyle(fontSize: 15.fSize)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: Colors.lightGreen),
                  onPressed: () {
                    // Handle add button press
                    controller
                        .createMealLogByFood(controller.foodMenuModels[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
