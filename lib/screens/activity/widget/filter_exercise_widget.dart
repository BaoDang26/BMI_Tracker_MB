import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/filter_exercise_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class FilterExerciseWidget extends GetView<FilterExerciseController> {
  const FilterExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.v,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              controller.toFilterTagFood();
            },
          ),
          SizedBox(
            width: 280.h,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.tagChecked.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 3.v, bottom: 3.v, right: 7.h),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text("${controller.tagChecked[index].tagName}"),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
