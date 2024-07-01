import 'package:flutter/material.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../../../controllers/meal_details_controller.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/entry_filed.dart';

class UpdateMealLogWidget extends StatelessWidget {
  UpdateMealLogWidget(this.index, {super.key});

  late int index;
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Update meal log"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    controller.updateMealLogByForm(index);
                  },
                  text: "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
