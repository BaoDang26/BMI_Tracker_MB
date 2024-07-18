import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/filter_search_meal_food_controller.dart';

import '../../util/app_export.dart';

class FilterTagFoodScreen extends StatelessWidget {
  final controller = Get.find<FilterSearchMealFoodController>();

  FilterTagFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Tags Food'),
      ),
      body: Obx(() {
        if (controller.tagTypeModels.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.tagTypeModels.length,
            itemBuilder: (context, index) {
              final tagType = controller.tagTypeModels[index];
              return ExpansionTile(
                title: Text(tagType.tagTypeName!),
                children: tagType.tags!.map((tag) {
                  return CheckboxListTile(
                    title: Text(tag.tagName!),
                    subtitle: Text(tag.tagDescription!),
                    value: tag.isChecked,
                    onChanged: (bool? value) {
                      controller.toggleCheckbox(tag);
                    },
                  );
                }).toList(),
              );
            },
          );
        }
      }),
    );
  }
}
