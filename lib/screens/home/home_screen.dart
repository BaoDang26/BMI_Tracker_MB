import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/screens/home/widget/activity_icon_widget.dart';
import 'package:flutter_health_menu/screens/home/widget/calories_of_day_wdiget.dart';
import 'package:flutter_health_menu/screens/home/widget/meal_item_widget.dart';

import 'package:flutter_health_menu/util/app_export.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends GetView<HomePageController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: appTheme.white,
          body: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(appTheme.green500),
            ),
          ),
        );
      }
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            toolbarHeight: 80.v,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    'Welcome ${controller.currentMember.value.fullName}',
                    // 'Welcome Van Tung',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.dateHome.value,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.goToNotification();
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: controller.date,
                    firstDate: DateTime.parse("2023-01-01"),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != controller.date) {
                    controller.onDatePicker(picked);
                  }
                },
                icon: const Icon(Icons.calendar_month),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.v),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PersonalInfo(),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10.v),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // Giá trị cao hơn làm cho bóng lớn hơn.
                            spreadRadius: 0,
                            // Giá trị cao hơn làm cho bóng mờ hơn.
                            blurRadius: 10,
                            // Dịch chuyển bóng
                            offset: const Offset(
                                0, 8), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: const DailyChartWidget()),
                  // Meal widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your meals',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 20.fSize,
                                  color: Colors.black,
                                ),
                      ),
                    ],
                  ),

                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.v),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // Giá trị cao hơn làm cho bóng lớn hơn.
                            spreadRadius: 0,
                            // Giá trị cao hơn làm cho bóng mờ hơn.
                            blurRadius: 10,
                            // Dịch chuyển bóng
                            offset: const Offset(
                                0, 8), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: _buildManageMealWidget(context)),

                  // Activity log
                  Container(
                    margin: EdgeInsets.only(top: 5.v),
                    width: double.infinity,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Workout',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            controller.goToActivityDetailsScreen();
                          },
                          child: Text(
                            'More',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildManageActivityWidget(context),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statistics',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                      ),
                      // const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              // now button
                              FilledButton(
                                onPressed: () {
                                  controller.goToWeightStatistics();
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: appTheme.blueA100,
                                  fixedSize: Size(150.h, 100.v),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Image(
                                  image: const AssetImage(
                                      'assets/images/weight-scale.png'),
                                  width: 60.adaptSize,
                                  height: 60.adaptSize,
                                ),
                              ),
                              Text(
                                'Weight Statistics'.tr,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              // now button
                              FilledButton(
                                onPressed: () {
                                  controller.goToCaloriesStatistics();
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: appTheme.yellow500,
                                  fixedSize: Size(150.h, 100.v),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Image(
                                  image: const AssetImage(
                                      'assets/images/calories.png'),
                                  width: 60.adaptSize,
                                  height: 60.adaptSize,
                                ),
                              ),
                              Text(
                                'Calories statistics',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildManageMealWidget(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Obx(
        () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.mealModels.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    child: MealItem(
                        title: controller.mealModels[index].mealType!,
                        calories: controller.mealModels[index].currentCalories!,
                        goalCalories:
                            controller.mealModels[index].defaultCalories!),
                  ),
                ],
              );
            }),
      )
    ]);
  }

  Widget _buildManageActivityWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130.v,
      child: Obx(
        () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.exerciseLogModel.isEmpty
                ? 1
                : controller.exerciseLogModel.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: controller.exerciseLogModel.isEmpty
                    ? ActivityIcon(
                        icon: Icons.add,
                        label: 'Add',
                        onPressed: () {
                          controller.goToActivityDetailsScreen();
                        },
                      )
                    : ActivityIcon(
                        emoji: controller.exerciseLogModel[index].emoji,
                        label:
                            "${controller.exerciseLogModel[index].caloriesBurned} kcal",
                        onPressed: () {
                          // Add icon button functionality here
                        },
                      ),
              );
            }),
      ),
    );
  }
}
