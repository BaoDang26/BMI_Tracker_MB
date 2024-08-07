import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';
import 'package:flutter_health_menu/screens/activity/widget/filter_exercise_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/exercise_model.dart';
import '../../../util/app_export.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  var controller = Get.find<ActivityLogController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.v,
          child: const FilterExerciseWidget(),
        ),
        SizedBox(
          height: 570.v,
          child: PagedListView<int, ExerciseModel>(
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
                    // subtitle: Text('${exerciseModel.}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.h),
                          child: IconButton(
                              onPressed: () {
                                controller.goToAddExerciseToActivityLog(
                                    exerciseModel);
                              },
                              icon:
                                  const Icon(Icons.arrow_forward_ios_outlined)),
                        ),
                      ],
                    ),
                    // onTap: () {
                    //
                    // },
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
          ),
        )
      ],
    );
  }
}
