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
          child: Form(
            key: controller.mealDetailsFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.food_bank_rounded),
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
                  validator: (value) {
                    return controller.validateFoodName(value!);
                  },
                  label: 'Food name',
                  placeholder: 'name',
                  textInputType: TextInputType.text,
                  controller: controller.foodNameEditController,
                ),
                EntryField(
                  validator: (value) {
                    return controller.validateCalories(value!);
                  },
                  label: 'Calories (kcal)',
                  placeholder: '200 kcal',
                  textInputType: TextInputType.number,
                  controller: controller.caloriesEditController,
                ),
                EntryField(
                  validator: (value) {
                    return controller.validateQuantity(value!);
                  },
                  label: 'Quantity',
                  placeholder: 'quantity',
                  textInputType: TextInputType.number,
                  controller: controller.quantityEditController,
                ),
                EntryField(
                  // enable: false,
                  validator: (value) {
                    return controller.validateServing(value!);
                  },
                  label: 'Serving',
                  placeholder: '1 serving',
                  textInputType: TextInputType.text,
                  controller: controller.unitEditController,
                ),
                SizedBox(height: 20.v),
                Center(
                  child: CustomElevatedButton(
                      onPressed: () {
                        // validate
                        final isValid = controller
                            .mealDetailsFormKey.currentState!
                            .validate();
                        if (!isValid) {
                          return;
                        }
                        controller.mealDetailsFormKey.currentState!.save();
                        controller.createMealLogByForm();
                      },
                      text: "Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
