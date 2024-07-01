import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/food_model.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FoodModel>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<FoodModel>(
        itemBuilder: (context, foodModel, index) {
          return ListTile(
            title: Text(foodModel.foodName),
            subtitle: Text(foodModel.serving),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Text('${foodModel.foodCalories} kcal',
                      style: TextStyle(fontSize: 15.fSize)),
                ),
                AsyncButtonBuilder(
                  loadingWidget: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                    controller.createMealLogByFood(foodModel);
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
              controller.goToFoodDetails(foodModel);
            },
          );
        },
        firstPageErrorIndicatorBuilder: (context) => Center(
          child: Text('Error loading first page'),
        ),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text('No items found'),
        ),
      ),
    );
  }
}
