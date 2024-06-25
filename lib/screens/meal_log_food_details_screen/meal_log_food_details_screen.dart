import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_log_food_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/widgets/dish_info.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:url_launcher/url_launcher.dart';

class MealLogFoodDetailsScreen extends GetView<MealLogFoodController> {
  MealLogFoodDetailsScreen({super.key});

  String _selectedUnit = 'Serving (30 g)';
  List<String> _units = [
    'Serving (30 g)',
    'Cup (150 g)',
    'Package (150 g)',
    'Gram'
  ];

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
              'Meal Food Details',
              style: TextStyle(color: Colors.black),
            ),
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
                        time:
                            "${controller.foodModel.value.foodTimeProcess} min",
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
                            backgroundColor: Colors.lightGreenAccent,
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
                            launchUrl(Uri.parse(
                                controller.foodModel.value.foodVideo!));
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          itemCount:
                              controller.foodModel.value.ingredients!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Text(
                              "${controller.foodModel.value.ingredients![index].ingredientName}",
                              // viewFood.recipes![index].ingredients!.ingredientName!
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
          bottomNavigationBar: GestureDetector(
            onTap: () {
              controller.toggleContainer();
            },
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                // User swiped up
                controller.expandContainer();
              } else if (details.primaryVelocity! > 0) {
                // User swiped down
                controller.collapseContainer();
              }
            },
            child: Obx(
              () => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: controller.isExpanded.value ? 280 : 140,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 120.v,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // Giá trị cao hơn làm cho bóng lớn hơn.
                            spreadRadius: 0,
                            // Giá trị cao hơn làm cho bóng mờ hơn.
                            blurRadius: 5,
                            // Dịch chuyển bóng
                            offset: const Offset(
                                0, -4), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            child: Image(
                              image: AssetImage(
                                  "assets/images/minus-sign-of-a-line-in-horizontal-position.png"),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 2),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomLeft:
                                                    Radius.circular(25))),
                                        child: Center(
                                            child: Obx(
                                          () => Text(
                                            " ${controller.quantity}",
                                            style:
                                                TextStyle(fontSize: 22.fSize),
                                          ),
                                        )),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(25),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Gram",
                                            style:
                                                TextStyle(fontSize: 22.fSize),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 10),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Add',
                                      style: TextStyle(fontSize: 22.fSize),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // phần mở rộng khi onTap hoặc vuốt
                    if (controller.isExpanded.value)
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Obx(
                                  () => NumberPicker(
                                    value: controller.quantity.value,
                                    minValue: 0,
                                    maxValue: 100,
                                    onChanged: (value) {
                                      controller.onChangedQuantity(value);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,

                                child: Obx(
                                      () => NumberPicker(
                                    value: controller.quantity.value,
                                    minValue: 0,
                                    maxValue: 100,
                                    onChanged: (value) {
                                      controller.onChangedQuantity(value);
                                    },
                                  ),
                                ),
                              ),
                               Expanded(
                                   flex: 3,

                                child: Text(_selectedUnit,   style:
                                TextStyle(fontSize: 22.fSize),
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
