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
              subtitle: Text('${exerciseModel.duration} minutes'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.h),
                      child: Text('${exerciseModel.caloriesBurned} kcal')),
                  AsyncButtonBuilder(
                    loadingWidget: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                    successWidget: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.check,
                        color: Colors.lightGreen,
                      ),
                    ),
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      controller.createActivityLogByExercise(exerciseModel);
                    },
                    loadingSwitchInCurve: Curves.bounceInOut,
                    loadingTransitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1.0),
                          end: const Offset(0, 0),
                        ).animate(animation),
                        child: child,
                      );
                    },
                    builder: (context, child, callback, state) {
                      return Material(
                        color: state.maybeWhen(
                          success: () => Colors.green[100],
                          orElse: () => Colors.lightGreen,
                        ),
                        // This prevents the loading indicator showing below the
                        // button
                        clipBehavior: Clip.hardEdge,
                        shape: const StadiumBorder(),
                        child: InkWell(
                          onTap: callback,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Icon(Icons.add_circle_outline,
                          color: Colors.lightGreen, size: 30.adaptSize),
                    ),
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
