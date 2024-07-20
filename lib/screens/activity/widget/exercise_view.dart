import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../controllers/activity_details_controller.dart';
import '../../../models/exercise_model.dart';
import '../../../util/app_export.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  var controller = Get.find<ActivityDetailsController>();

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, ExerciseModel>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<ExerciseModel>(
        itemBuilder: (context, exerciseModel, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(
                exerciseModel.emoji ?? '',
                style: TextStyle(fontSize: 30.fSize),
              ),
              title: Text(exerciseModel.exerciseName ?? 'null'),
              subtitle: Text('${exerciseModel.tagName}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.h),
                    child: IconButton(
                        onPressed: () {
                          controller.goToAddActivityLog();
                        },
                        icon: const Icon(Icons.arrow_forward_ios_outlined)),
                   ),
                ],
              ),
              onTap: () {
                // Handle tile tap functionality here
              },
            ),
          );
        },
        firstPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Error loading first page'),
        ),
        noItemsFoundIndicatorBuilder: (context) => const Center(
          child: Text('No items found'),
        ),
      ),
    );
  }
}
