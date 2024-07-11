import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/filter_search_meal_food_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class FilterSearch extends StatefulWidget {
  const FilterSearch({super.key});

  @override
  _FilterSearchState createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  var controller = Get.put(FilterSearchMealFoodController());

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0.v,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _focusNode.unfocus();
              Get.bottomSheet(
                Container(
                  height: 500.v,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: controller.tagCheckBoxOptions.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => CheckboxListTile(
                          title: Text(
                              "${controller.tagCheckBoxOptions[index].tagName}"),
                          subtitle: Text(
                              "${controller.tagCheckBoxOptions[index].tagDescription}"),
                          value: controller.tagCheckBoxOptions[index].checked,
                          onChanged: (value) {
                            controller.toggleCheckbox(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(
            width: 300.h,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.tagChecked.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 3.v, bottom: 3.v, right: 7.h),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text("${controller.tagChecked[index].tagName}"),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
