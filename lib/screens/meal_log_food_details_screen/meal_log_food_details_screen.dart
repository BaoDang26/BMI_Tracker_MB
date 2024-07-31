import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_log_food_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/widgets/dish_info.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:url_launcher/url_launcher.dart';

class MealLogFoodDetailsScreen extends GetView<MealLogFoodController> {
  const MealLogFoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Food Details',
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
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListView.builder(
                          itemCount: controller.foodModel.value.recipes!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5.v),
                              decoration: ShapeDecoration(
                                color: const Color.fromARGB(255, 230, 250, 208),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        padding: const EdgeInsets.all(20),
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
                                            height: 64.adaptSize,
                                            width: 64.adaptSize,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.v),
                                    child: Column(
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
          bottomNavigationBar: GestureDetector(
            onTap: () {
              controller.toggleContainer();
            },
            onVerticalDragEnd: (details) {
              controller.toggleContainer();
            },
            child: Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: controller.isExpanded.value ? 280.v : 140.v,
                child: Column(
                  children: <Widget>[
                    // phần  trên của container expand
                    Container(
                      height: 140.v,
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
                          // image thanh ngang
                          Container(
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              "assets/images/minus-sign-of-a-line-in-horizontal-position.png",
                              width: 32.adaptSize,
                            ),
                          ),
                          // wiget chứa Quantity và serving
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // quantity
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.h),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 2),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25),
                                                    bottomLeft:
                                                        Radius.circular(25))),
                                        child: Center(
                                            child: Obx(
                                          () => Text(
                                            "${controller.quantity.value}",
                                            style:
                                                TextStyle(fontSize: 22.fSize),
                                          ),
                                        )),
                                      ),
                                    ),
                                    // Serving
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(25),
                                          ),
                                        ),
                                        child: Center(
                                          child: Obx(
                                            () => Text(
                                              "${controller.calories} kcal",
                                              style:
                                                  TextStyle(fontSize: 22.fSize),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // button add
                                controller.isUpdate.value
                                    ? Obx(
                                        () => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 100.h,
                                              vertical: 10.v),
                                          width: double.infinity,
                                          child: controller.quantity > 0
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    controller.updateMealLog();
                                                  },
                                                  child: Text(
                                                    'Update',
                                                    style: TextStyle(
                                                        fontSize: 22.fSize),
                                                  ),
                                                )
                                              :
                                              // button disable khi chưa có quantity
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black12,
                                                    // Màu nền của nút là đỏ
                                                    foregroundColor:
                                                        Colors.white,
                                                    // Màu chữ của nút là trắng
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0), // Độ cong viền nút
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Update',
                                                    style: TextStyle(
                                                        fontSize: 22.fSize),
                                                  ),
                                                ),
                                        ),
                                      )
                                    : Obx(
                                        () => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 100.h,
                                              vertical: 10.v),
                                          width: double.infinity,
                                          child: controller.quantity > 0
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    controller.addMealLog();
                                                  },
                                                  child: Text(
                                                    'Add',
                                                    style: TextStyle(
                                                        fontSize: 22.fSize),
                                                  ),
                                                )
                                              :
                                              // button disable khi chưa có quantity
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black12,
                                                    // Màu nền của nút là đỏ
                                                    foregroundColor:
                                                        Colors.white,
                                                    // Màu chữ của nút là trắng
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0), // Độ cong viền nút
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Add',
                                                    style: TextStyle(
                                                        fontSize: 22.fSize),
                                                  ),
                                                ),
                                        ),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // phần mở rộng khi onTap hoặc vuốt
                    if (controller.isExpanded.value)
                      Expanded(
                        child: Row(
                          children: [
                            // thanh cuộn quantity
                            Expanded(
                                flex: 2,
                                child: NumberPicker(
                                  // haptics: true,
                                  minValue: 0,
                                  maxValue: controller.maxSizeQuantity,
                                  textMapper: (index) {
                                    if (index == '0') {
                                      return '-';
                                    }
                                    // Đưa ra một mục hiển thị cho mỗi giá trị index
                                    return index;
                                  },
                                  selectedTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.fSize),
                                  value: controller.quantitySelectedIndex.value,
                                  onChanged: (value) {
                                    controller.setQuantitySelectedIndex(value);
                                  },
                                )),
                            // thanh cuộn quantity chia tỉ lệ của serving
                            Expanded(
                              flex: 2,
                              child: NumberPicker(
                                // haptics: true,
                                minValue: 0,
                                maxValue: controller.fractionValues.length - 1,
                                value: controller
                                    .fractionQuantitySelectedIndex.value,
                                textMapper: (index) {
                                  if (index == '0') {
                                    return '-';
                                  }
                                  // Đưa ra một mục hiển thị cho mỗi giá trị index
                                  return controller.fractionValues
                                      .elementAt(int.parse(index));
                                },
                                selectedTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.fSize),
                                onChanged: (value) {
                                  controller
                                      .setFractionQuantitySelectedIndex(value);
                                },
                              ),
                            ),
                            //gia trị của serving
                            Expanded(
                                flex: 3,
                                child: Obx(
                                  () => Center(
                                    child: Text(
                                      controller.foodModel.value.serving!,
                                      style: TextStyle(fontSize: 22.fSize),
                                    ),
                                  ),
                                )),
                          ],
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
