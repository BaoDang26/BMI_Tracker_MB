import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/widgets/custom_elevated_button.dart';
import 'package:flutter_health_menu/widgets/entry_filed.dart';

import '../../util/app_export.dart';

class AddMealLogScreen extends StatefulWidget {
  const AddMealLogScreen({super.key});

  @override
  State<AddMealLogScreen> createState() => _AddMealLogScreenState();
}

class _AddMealLogScreenState extends State<AddMealLogScreen> {
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              controller.mealType.value.name,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.no_meals_rounded),
                    ),
                    SizedBox(height: 10.v),
                    Text(
                      'Custom Entry',
                      style: TextStyle(
                          fontSize: 18.fSize, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.v),
              EntryField(
                label: 'Food name',
                placeholder: 'name',
                controller: controller.foodNameEditController,
              ),
              EntryField(
                label: 'Calories (kcal)',
                placeholder: '200 kcal',
                controller: controller.caloriesEditController,
              ),
              EntryField(
                label: 'Quantity',
                placeholder: 'quantity',
                controller: controller.quantityEditController,
              ),
              EntryField(
                label: 'Unit',
                placeholder: 'unit',
                controller: controller.unitEditController,
              ),
              SizedBox(height: 20.v),
              Center(
                child: CustomElevatedButton(
                    onPressed: () {
                      controller.createMealLogByForm();
                    },
                    text: "Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
