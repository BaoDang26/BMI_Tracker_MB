// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/food_controller.dart';

import 'package:flutter_health_menu/screens/food_details/food_detail_screen.dart';
import 'package:get/get.dart';

import '../models/food_model2.dart';

class RecipesRow extends StatelessWidget {
  final List<MenuFoodModel> foods;

  // final
  const RecipesRow({
    Key? key,
    required this.foods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodController = Get.put(FoodController());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: double.infinity,
        height: 240,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: foodController.foodList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const FoodDetailScreen(), arguments: [foods[index]]);
                    // Get.to(const FoodDetailScreen());
                  },
                  child: SizedBox(
                    width: 170,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            //! photo
                            Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfDLQkEi-UgkZ30hfBkp0gAhlsasZLBqvL4A&usqp=CAU'),
                                    foods[index].foodPhoto,
                                  ),
                                ),
                              ),
                            ),

                            //! name
                            Text(
                              foods[index].foodName,
                              // 'Eggs Fried',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.timelapse),
                                const SizedBox(width: 7),
                                Text('${foods[index].foodTimeProcess} minutes')
                                // Text('10 minutes')
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.people),
                                const SizedBox(width: 7),
                                Text('3 servings')
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.local_fire_department),
                                const SizedBox(width: 7),
                                // Text('450 kcal')
                                Text('${foods[index].foodCalories} kcal')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
