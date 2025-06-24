import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/filter_exercise_controller.dart';
import 'package:flutter_health_menu/models/tag_type_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/util/tag_emoji_utils.dart';

import '../../../models/tag_model.dart';

class FilterExerciseWidget extends GetView<FilterExerciseController> {
  const FilterExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.v,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // IconButton(
          //   icon: const Icon(Icons.filter_list),
          //   onPressed: () {
          //     // controller.toFilterTagExercise();
          //   },
          // ),
          PopupMenuButton<TagModel>(
            icon: const Icon(Icons.filter_list),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<TagModel>(
                  child: SizedBox(
                    width: 200, // Width of the dropdown
                    height: 200, // Height to show limited items at a time
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          children: controller.tagModels.map((TagModel tag) {
                            return ListTile(
                              title: Text(
                                  '${TagEmojiUtils.getEmojiForTag(tag.tagID)} - ${tag.tagName}'),
                              onTap: () {
                                controller.setSelected(tag);
                                Navigator.pop(context); // Close the dropdown
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
          ),
          Obx(() {
            if (controller.tagChecked.value.tagID != null &&
                controller.tagChecked.value.tagID != -1) {
              return Obx(() => Container(
                    margin: EdgeInsets.only(top: 3.v, bottom: 3.v, right: 7.h),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text("${controller.tagChecked.value.tagName}"),
                  ));
            }
            return Container();
          })
        ],
      ),
    );
  }
}
