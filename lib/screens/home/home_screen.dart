
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/meal_controller.dart';
import 'package:flutter_health_menu/controllers/food_controller.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/screens/screens.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foodController = Get.put(FoodController());
    final loginController = Get.put(LoginController());

    // final mealController = Get.put(MealController());
    MemberModel currentMember = loginController.loginedMember.value;
    // final menuController = Get.put(MenuFController());
    // var heght2 = currentMember.userbodymaxs!.heght;
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
                  Text(
                    'Welcome ${currentMember.fullname}',
                    // 'Welcome Van Tung',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'What would you like\nto cook today?',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
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
                PersonalInfo(
                  height: currentMember.height ?? 20,
                  weight: currentMember.weight ?? 20,
                  age: currentMember.age ?? 23,
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BMIContainer(
                        topText: '${(currentMember.bmi)?.toStringAsFixed(1)}',
                        // '45.2',
                        bottomText: 'BMI'),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BMIContainer(
                            topText: '${(currentMember.bmr)?.round()}',
                            // '20.0',
                            bottomText: 'BMR'),
                        BMIContainer(
                            topText: '${(currentMember.tdee)?.round()}',
                            bottomText: 'TDEE'),
                      ],
                    )
                  ],
                ),
                _buildManageMealWidget(context),
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
                  if (foodController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return RecipesRow(foods: foodController.foodList);
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
    final mealController = Get.put(MealController());

    return SizedBox(
      height: 320,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Your meals',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 20,
                color: Colors.black,
              ),
        ),
        Obx(
          () => ListView.builder(
              shrinkWrap: true,
              itemCount: mealController.mealModels.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      child: MealItem(
                          title: mealController.mealModels[index].mealType!,
                          calories:
                              mealController.mealModels[index].currentCalories!,
                          goalCalories: mealController
                              .mealModels[index].defaultCalories!),
                    ),
                  ],
                );
              }),
        )
       ]),
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
        leading: const Icon(Icons.fastfood, size: 40),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: Text('$calories / $goalCalories Cal'),
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
