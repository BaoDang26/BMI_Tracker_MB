import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';

import 'package:flutter_health_menu/util/app_export.dart';

class RecipesRow extends StatelessWidget {
  // final
  const RecipesRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: double.infinity,
        height: 245.v,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.foodList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.goToFoodDetailsScreen(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.h),
                    width: 155.h,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 20.v),
                        child: Column(
                          children: [
                            //! photo
                            Container(
                              height: 110.v,
                              width: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfDLQkEi-UgkZ30hfBkp0gAhlsasZLBqvL4A&usqp=CAU'),
                                    controller.foodList[index].foodPhoto,
                                  ),
                                ),
                              ),
                            ),

                            //! name
                            Text(
                              controller.foodList[index].foodName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.v),
                            Row(
                              children: [
                                const Icon(Icons.timelapse),
                                SizedBox(width: 7.v),
                                Text(
                                    '${controller.foodList[index].foodTimeProcess} minutes')
                                // Text('10 minutes')
                              ],
                            ),
                            // const Row(
                            //   children: [
                            //     Icon(Icons.people),
                            //     const SizedBox(width: 7),
                            //     Text('3 servings')
                            //   ],
                            // ),
                            Row(
                              children: [
                                const Icon(Icons.local_fire_department),
                                SizedBox(width: 7.v),
                                // Text('450 kcal')
                                Text(
                                    '${controller.foodList[index].foodCalories} kcal')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
