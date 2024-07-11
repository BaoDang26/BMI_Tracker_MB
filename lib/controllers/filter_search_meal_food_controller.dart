import 'dart:convert';

import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/repositories/tag_type_repository.dart';
import 'package:flutter_health_menu/screens/meal/model/tag_checkbox_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class FilterSearchMealFoodController extends GetxController {
  RxList<TagCheckBoxModel> tagCheckBoxOptions = [
    TagCheckBoxModel(tagName: "Breakfast", tagID: 1, tagDescription: "vvv"),
    TagCheckBoxModel(tagName: "Lunch", tagID: 2, tagDescription: "vvv"),
    TagCheckBoxModel(tagName: "Dinner", tagID: 3, tagDescription: "aaa"),
  ].obs;

  RxList<TagCheckBoxModel> tagChecked = RxList.empty();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void toggleCheckbox(int index) {
    tagCheckBoxOptions[index].checked = !tagCheckBoxOptions[index].checked;
    if (tagCheckBoxOptions[index].checked) {
      tagChecked.add(tagCheckBoxOptions[index]);
    } else {
      tagChecked.remove(tagCheckBoxOptions[index]);
    }
    filterFoodWithTag();

    tagCheckBoxOptions.refresh();
  }

  Future<void> fetchFilterSearchData() async {
    var response = await TagTypeRepository.getAllTagFood();
    if (response.statusCode == 200) {
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          json.decode(response.body)['message']);
    }
  }

  Future<void> filterFoodWithTag() async {
    var mealDetailsController = Get.find<MealDetailsController>();
    // final filteredItems = mealDetailsController.foodModels
    //     .where((item) => item.foodName.toLowerCase().contains("Miso"))
    //     .toList();
    // print('filteredItems=${}');
    // mealDetailsController.pagingController.itemList = filteredItems;
    // mealDetailsController.pagingController.refresh();
  }
}
