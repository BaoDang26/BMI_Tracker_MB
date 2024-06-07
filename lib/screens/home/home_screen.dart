import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/models/food_model2.dart';
import 'package:flutter_health_menu/screens/home/statistics_calories_screen.dart';
import 'package:flutter_health_menu/screens/screens.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// test với data trong database với date
  final homeController = Get.put(HomePageController.withDate("2024-05-31"));

  // final homeController = Get.put(HomePageController());
  var foodList = <MenuFoodModel>[].obs;

  @override
  Widget build(BuildContext context) {
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
                      'Welcome ${homeController.currentMember.value.fullName}',
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
                    Get.to(const NotificationScreen());
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context).primaryColor,
                  ))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  prefixicon: const Icon(Icons.search),
                  hintTxt: 'Search an ingredient or a recipe',
                ),
                const SizedBox(
                  height: 15,
                ),
                // Obx(
                //   () => PersonalInfo(
                //     height: homeController.currentMember.value.height ?? 20,
                //     weight: homeController.currentMember.value.weight ?? 20,
                //     age: homeController.currentMember.value.age ?? 23,
                //   ),
                // ),

                Obx(() {
                  if (homeController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return PersonalInfo(height: homeController.currentMember.value.height ?? 20,
                    weight: homeController.currentMember.value.weight ?? 20,
                    age: homeController.currentMember.value.age ?? 23,);
                  }
                }),

                  const SizedBox(height: 15),
                Obx(() {
                  if (homeController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BMIContainer(
                          topText:
                              '${(homeController.currentMember.value.bmi)?.toStringAsFixed(1)}',
                          // '45.2',
                          bottomText: 'BMI'),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BMIContainer(
                              topText:
                                  '${(homeController.currentMember.value.bmr)?.round()}',
                              // '20.0',
                              bottomText: 'BMR'),
                          BMIContainer(
                              topText:
                                  '${(homeController.currentMember.value.tdee)?.round()}',
                              bottomText: 'TDEE'),
                        ],
                      )
                    ],
                  );
                  }
                }),
                
                // Obx(
                //   () => Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       BMIContainer(
                //           topText:
                //               '${(homeController.currentMember.value.bmi)?.toStringAsFixed(1)}',
                //           // '45.2',
                //           bottomText: 'BMI'),
                //       const SizedBox(
                //         height: 15,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           BMIContainer(
                //               topText:
                //                   '${(homeController.currentMember.value.bmr)?.round()}',
                //               // '20.0',
                //               bottomText: 'BMR'),
                //           BMIContainer(
                //               topText:
                //                   '${(homeController.currentMember.value.tdee)?.round()}',
                //               bottomText: 'TDEE'),
                //         ],
                //       )
                //     ],
                //   ),
                // ),

                _buildManageMealWidget(context),
                _buildManageActivityWidget(context),
                const SizedBox(height: 15),
                // Recipe for you
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recipes For You',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 20,
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
                  if (homeController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return RecipesRow(foods: homeController.foodList);
                  }
                }),
                const SizedBox(height: 15),

                // Popular recipes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular recipes',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 20,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildManageMealWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your meals',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
            ),
            TextButton(
              child: Text(
              'More',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
            ),
              onPressed: () {
                Get.to(() => MealDetailsScreen());
              },
            ),

            TextButton(
              child: Text("Chart"),
              onPressed: () {
                // màn hình biểu đồ track calories trong 1 tuần
                Get.to(() => StatisticsCaloriesScreen());
              },
            ),
          ],
        ),
        Obx(
          () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.mealModels.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      child: MealItem(
                          title: homeController.mealModels[index].mealType!,
                          calories:
                              homeController.mealModels[index].currentCalories!,
                          goalCalories: homeController
                              .mealModels[index].defaultCalories!),
                    ),
                  ],
                );
              }),
        )
      ]),
    );
  }

  Widget _buildManageActivityWidget(BuildContext context) {
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
                  homeController.goToActivityDetailsScreen();
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
                itemCount: homeController.exerciseLogModel.isEmpty
                    ? 1
                    : homeController.exerciseLogModel.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: homeController.exerciseLogModel.isEmpty
                        ? ActivityIcon(
                            icon: Icons.add,
                            label: 'Add',
                            onPressed: () {
                              // Add icon button functionality here
                            },
                          )
                        : ActivityIcon(
                            emoji: homeController.exerciseLogModel[index].emoji,
                            label:
                                "${homeController.exerciseLogModel[index].caloriesBurned} kcal",
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

class MealItem extends StatelessWidget {
  final String title;
  final int calories;
  final int goalCalories;

  const MealItem(
      {super.key,
      required this.title,
      required this.calories,
      required this.goalCalories});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const
          CircleAvatar(
              child: Icon(
                Icons.fastfood,
                color: Colors.white,
              ),
              radius: 30,
              backgroundColor: Color.fromARGB(255, 153, 211, 157),
            ),
        //  Icon(Icons.fastfood, size: 40),

        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: Text('$calories / $goalCalories kcal'),
        // trailing: Icon(Icons.add, color: Colors.teal),
        trailing: IconButton(
          onPressed: () {
            print('Add meal button');
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
                    style: const TextStyle(fontSize: 30),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
