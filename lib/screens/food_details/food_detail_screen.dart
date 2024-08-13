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
                      servings:
                          "serving: ${controller.foodModel.value.serving}",
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
                        "carbs:${controller.foodModel.value.carbs} g, "
                        "protein:${controller.foodModel.value.protein} g,"
                        " fat:${controller.foodModel.value.fat} g",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  // food link video
                  Row(
                    children: [
                      Text(
                        'Proccessing Video',
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

                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListView.builder(
                        itemCount: controller.foodModel.value.recipes!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 300.v,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: ShapeDecoration(
                              color: Color.fromARGB(255, 230, 250, 208),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: ShapeDecoration(
                                        // color:
                                        //     Color.fromARGB(255, 194, 241, 140),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Image.network(
                                          controller
                                                  .foodModel
                                                  .value
                                                  .recipes![index]
                                                  .ingredientPhoto ??
                                              "https://firebasestorage.googleapis.com/v0/b/test-ultilites.appspot.com/o/applepie.jpg?alt=media&token=a567920b-58b2-4bb8-8ea7-f59a54c5326d",
                                          height: 65.adaptSize,
                                          width: 70.adaptSize,
                                          fit: BoxFit.cover,
                                          // centerSlice: Rect.fromCircle(center: Offset.fromDirection(1.0), radius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 130.h,
                                      child: Text(
                                        "${controller.foodModel.value.recipes![index].ingredientName}",
                                        maxLines: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 75.h,
                                  // padding:
                                  //     EdgeInsets.symmetric(horizontal: 4.v),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${controller.foodModel.value.recipes![index].quantity}",
                                      ),
                                      Text(
                                        "${controller.foodModel.value.recipes![index].unit}",
                                      ),
                                    ],
                                  ),
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
