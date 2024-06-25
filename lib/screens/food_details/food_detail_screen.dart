import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/food_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/widgets.dart';

class FoodDetailScreen extends GetView<FoodController> {
  const FoodDetailScreen({super.key});

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
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Food Details',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.goToFeedBack();
              },
              icon: const Icon(
                Icons.feedback,
              ),
            ),
          ],
        ),
        body: Obx(() {
          // Check the loading state
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 180.v,
                    margin: EdgeInsets.symmetric(vertical: 10.v),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //! photo
                      image: DecorationImage(
                        image: NetworkImage(controller
                                .foodModel.value.foodPhoto ??
                            'https://i.ytimg.com/vi/XowvxiGYsRI/maxresdefault.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //! Name
                  Text(
                    controller.foodModel.value.foodName ?? "food name",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.v),
                    child: DishInfo(
                      kcal: "${controller.foodModel.value.foodCalories}",
                      servings: "${controller.foodModel.value.serving}",
                      time: "${controller.foodModel.value.foodTimeProcess} min",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.v),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        controller.foodModel.value.description ??
                            'This is the notes!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),

                  // Danh sách tag của food
                  Obx(
                    () => Wrap(
                      spacing: 8.0,
                      // Khoảng cách giữa các tag theo chiều ngang
                      runSpacing: 4.0,
                      // Khoảng cách giữa các dòng tag
                      children: controller.foodTags.map((tag) {
                        return Chip(
                          label: Text(tag.tagName ?? 'Unknown'),
                          backgroundColor: Color.fromARGB(255, 194, 241, 140),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Text(
                    'Nutrition',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.v),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        controller.foodModel.value.foodNutrition ??
                            "food nutrition",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  // food link video
                  Row(
                    children: [
                      Text(
                        'Link processing video',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrl(
                              Uri.parse(controller.foodModel.value.foodVideo!));
                        },
                        child: Text(
                          'Video Link',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    // fontSize: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: ListView.builder(
                  //     // width: double.infinity,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     // itemCount: ingredientController.ingredientList.length,
                  //     itemCount: 1,
                  //     itemBuilder: (context, index) {
                  //       return Text(
                  //         // ingredientController
                  //         //     .ingredientList[index].ingredients!.ingredientName!,
                  //         // 'This is the ingredient!!!',
                  //         ingredients.toString(),
                  //         style: Theme.of(context).textTheme.bodyLarge,
                  //       );
                  //     },
                  //     // child: Text(
                  //     //   viewIngredient.ingredientName!,
                  //     //   style: Theme.of(context).textTheme.bodyLarge,

                  //     // ),
                  //   ),
                  // ),

                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListView.builder(
                        itemCount: controller.foodModel.value.recipes!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: ShapeDecoration(
                              color: Color.fromARGB(255, 230, 250, 208),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Image(
                                        image: NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/test-ultilites.appspot.com/o/applepie.jpg?alt=media&token=a567920b-58b2-4bb8-8ea7-f59a54c5326d"),
                                        height: 65.adaptSize,

                                        // centerSlice: Rect.fromCircle(center: Offset.fromDirection(1.0), radius: BorderRadius.circular(20),
                                      ),
                                      decoration: ShapeDecoration(
                                        // color:
                                        //     Color.fromARGB(255, 194, 241, 140),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(20),
                                    ),
                                    Text(
                                      "${controller.foodModel.value.recipes![index].ingredientName}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${controller.foodModel.value.recipes![index].quantity}",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${controller.foodModel.value.recipes![index].unit}",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
