import 'dart:convert';

import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/models/tag_model.dart';
import 'package:flutter_health_menu/models/tag_type_model.dart';
import 'package:flutter_health_menu/repositories/tag_type_repository.dart';
import 'package:flutter_health_menu/screens/filter_tag_food/filter_tag_food_screen.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class FilterSearchMealFoodController extends GetxController {
  RxList<TagTypeModel> tagTypeModels = RxList.empty();
  RxList<TagModel> tagChecked = RxList.empty();

  @override
  Future<void> onInit() async {
    await fetchFilterSearchData();
    super.onInit();
  }

  void toggleCheckbox(TagModel tag) {
    tag.isChecked = !tag.isChecked;
    if (tag.isChecked) {
      tagChecked.add(tag);
    } else {
      tagChecked.remove(tag);
    }
    filterFoodWithTag();
    tagTypeModels.refresh();
  }

  Future<void> fetchFilterSearchData() async {
    var response = await TagTypeRepository.getAllTagFood();
    if (response.statusCode == 200) {
      tagTypeModels.value = tagTypeModelsFromJson(response.body);
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
    mealDetailsController.pagingController.refresh();
  }

  void toFilterTagFood() {
    Get.to(() => FilterTagFoodScreen());
  }
}
