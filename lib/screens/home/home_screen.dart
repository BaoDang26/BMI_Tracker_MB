import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/models/enums/EMealType.dart';
import 'package:flutter_health_menu/screens/home/widget/calories_of_day_wdiget.dart';

import 'package:flutter_health_menu/util/app_export.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends GetView<HomePageController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.transparent),
        );
      }
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        'Welcome ${controller.currentMember.value.fullName}',
                        // 'Welcome Van Tung',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      'What would you like\nto cook today?',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      controller.goToNotification();
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: Theme.of(context).primaryColor,
                    ))
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.v),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CustomTextFormField(
                  //   prefixicon: const Icon(Icons.search),
                  //   hintTxt: 'Search an ingredient or a recipe',
                  // ),
                  // SizedBox(
                  //   height: 15.v,
                  // ),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return const CircularProgressIndicator();
                    } else {
                      return PersonalInfo(
                        height: controller.currentMember.value.height ?? 20,
                        weight: controller.currentMember.value.weight ?? 20,
                        age: controller.currentMember.value.age ?? 23,
                      );
                    }
                  }),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return const CircularProgressIndicator();
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BMIContainer(
                              topText:
                                  '${(controller.currentMember.value.bmi)?.toStringAsFixed(1)}',
                              // '45.2',
                              bottomText: 'BMI'),
                          SizedBox(
                            height: 15.v,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BMIContainer(
                                  topText:
                                      '${(controller.currentMember.value.bmr)?.round()}',
                                  // '20.0',
                                  bottomText: 'BMR'),
                              BMIContainer(
                                  topText:
                                      '${(controller.currentMember.value.tdee)?.round()}',
                                  bottomText: 'TDEE'),
                            ],
                          )
                        ],
                      );
                    }
                  }),
                  // chart calories of day
                  DailyChartWidget(),
                  _buildManageMealWidget(context),

                  _buildManageActivityWidget(context),
                  SizedBox(height: 15.v),
                  // Recipe for you
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recipes For You',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 20.fSize,
                                  color: Colors.black,
                                ),
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 15,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const CircularProgressIndicator();
                    } else {
                      return const RecipesRow();
                    }
                  }),
                  // SizedBox(height: 15.v),

                  // // Popular recipes
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Popular recipes',
                  //       style:
                  //           Theme.of(context).textTheme.headlineSmall!.copyWith(
                  //                 fontSize: 20.fSize,
                  //                 color: Colors.black,
                  //               ),
                  //     ),
                  //     CircleAvatar(
                  //       backgroundColor: Theme.of(context).primaryColor,
                  //       radius: 15,
                  //       child: const Icon(
                  //         Icons.arrow_forward,
                  //         color: Colors.white,
                  //       ),
                  //     )
                  //   ],
                  // ),
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your meals',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 20.fSize,
                  color: Colors.black,
                ),
          ),
          TextButton(
            child: Text(
              'Statistics',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 20.fSize,
                    color: Colors.black,
                  ),
            ),
            onPressed: () {
              // màn hình biểu đồ track calories trong 1 tuần
              controller.goToTrackCalories();
            },
          ),
        ],
      ),
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
    int size = controller.exerciseLogModel.length < 5
        ? controller.exerciseLogModel.length
        : 4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Activities',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          ),
        ),
        // Activity Icons Row
        SizedBox(
          width: double.infinity,
          height: 120,
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
        )
      ],
    );
  }
}

class MealItem extends StatefulWidget {
  final EMealType title;
  final int calories;
  final int goalCalories;

  const MealItem(
      {super.key,
      required this.title,
      required this.calories,
      required this.goalCalories});

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  var controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Color.fromARGB(255, 153, 211, 157),
          child: Icon(
            Icons.fastfood,
            color: Colors.white,
          ),
        ),
        //  Icon(Icons.fastfood, size: 40)
        title: Text(widget.title.name, style: TextStyle(fontSize: 18)),
        subtitle: Text('${widget.calories} / ${widget.goalCalories} kcal'),
        // trailing: Icon(Icons.add, color: Colors.teal),
        trailing: IconButton(
          onPressed: () {
            controller.goToMealDetails(widget.title);
          },
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 15,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }
}

class ActivityIcon extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String label;
  final VoidCallback onPressed;

  const ActivityIcon({
    Key? key,
    this.icon,
    this.emoji,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: icon != null
                ? Icon(icon, size: 30, color: Colors.black)
                : Text(
                    emoji ?? '',
                    style: TextStyle(fontSize: 30),
                  ),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
