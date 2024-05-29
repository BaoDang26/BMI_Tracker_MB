// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/meal_controller.dart';
import 'package:flutter_health_menu/controllers/menu_controller.dart';
import 'package:flutter_health_menu/controllers/food_controller.dart';
import 'package:flutter_health_menu/controllers/userbodymax_controller.dart';
import 'package:flutter_health_menu/models/userBodyMax_model.dart';
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
    // var heght2 = currentUser.userbodymaxs!.heght;
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
                    // 'Welcome ${currentUser.fullname}',
                    'Welcome Van Tung',
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
                  // height: currentUser.height ?? 20,
                  height: 20,
                  weight: 20,
                  age: 23,
                  // weight: currentUser.weight ?? 20,
                  // age: currentUser.age ?? 23,
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BMIContainer(
                        topText:
                            // '${(currentUser.bmi)?.toStringAsFixed(1)}',
                            '45.2',
                        bottomText: 'BMI'),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BMIContainer(
                            topText:
                                // '${(currentUser.bmr)?.round()}',
                                '20.0',
                            bottomText: 'BMR'),
                        BMIContainer(
                            topText: '1100.0', bottomText: 'TDEE'),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
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
                // Obx(() {
                //   if (foodController.isLoading.value) {
                //     return const CircularProgressIndicator();
                //   } else {
                //     return RecipesRow(foods: foodController.foodList);
                //   }
             
                // }),
                RecipesRow(),


                const SizedBox(height: 15),
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
                // Obx(() {
                //   if (foodController.isLoading.value) {
                //     return const CircularProgressIndicator();
                //   } else {
                //     // return RecipesRow(foods: foodController.foodList);
                    
                //   }
                // }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
