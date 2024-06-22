import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.foodMenuModels.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${controller.foodMenuModels[index].foodName}"),
            subtitle: Text("${controller.foodMenuModels[index].serving}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                      '${controller.foodMenuModels[index].foodCalories} kcal',
                      style: TextStyle(fontSize: 15.fSize)),
                ),
                // button add meal log
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
                    controller
                        .createMealLogByFood(controller.foodMenuModels[index]);
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
              controller.goToFoodDetails(controller.foodMenuModels[index]);
            },
          );
        },
      ),
    );
  }
}
