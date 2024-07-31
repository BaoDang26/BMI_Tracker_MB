import 'dart:convert';

import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/models/food_details_model.dart';
import 'package:flutter_health_menu/models/food_tag_basic_model.dart';
import 'package:flutter_health_menu/models/meal_log_model.dart';
import 'package:flutter_health_menu/repositories/food_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/util/fraction_util.dart';
import 'package:http/http.dart' as http;

class MealLogFoodController extends GetxController {
  Rx<FoodDetailsModel> foodModel = FoodDetailsModel().obs;
  RxList<FoodTag> foodTags = <FoodTag>[].obs;

  var isLoading = true.obs;

  // biến kiểm saots việt mở or đóng của Container expand
  RxBool isExpanded = false.obs;

  // Kiểm tra trạng thái create hay update
  RxBool isUpdate = false.obs;

  RxDouble quantity = 0.0.obs;
  RxInt calories = 0.obs;

  //giá trị mặc định của số lượng chia theo phân số
  final List<String> fractionValues = [
    '0',
    '1/8',
    '1/4',
    // '1/3',
    '1/2',
    // '2/3',
    '3/4',
    '7/8',
  ];
  final int maxSizeQuantity = 100;

  var quantitySelectedIndex = 0.obs;
  var fractionQuantitySelectedIndex = 0.obs;

  void setQuantitySelectedIndex(int index) {
    if (index >= 0 && index <= 100) {
      quantitySelectedIndex.value = index;
      setQuantityValue();
    }
  }

  void setFractionQuantitySelectedIndex(int index) {
    int length = fractionValues.length;
    if (index >= 0 && index < length) {
      fractionQuantitySelectedIndex.value = index;
      setQuantityValue();
    }
  }

  void setQuantityValue() {
    int quantitySelected = quantitySelectedIndex.value;
    int fractionIndex = fractionQuantitySelectedIndex.value;

    double fractionValue = 0.0;
    if (fractionIndex > 0) {
      var parts = fractionValues[fractionIndex].split('/');
      double numerator = double.parse(parts[0]);
      double denominator = double.parse(parts[1]);
      fractionValue = numerator / denominator;
    }
    quantity.value = double.parse(
        (quantitySelected.toDouble() + fractionValue).toStringAsFixed(3));
    calories.value = (quantity.value * foodModel.value.foodCalories!).toInt();
  }

  // xử lý event đóng mở của container
  void toggleContainer() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  Future<void> onInit() async {
    await fetchFoodDetails();

    super.onInit();
  }

  Future<void> fetchFoodDetails() async {
    isLoading.value = true;

    final arguments = Get.arguments;
    int foodID = -1;
    // Kiểm tra kiểu dữ liệu của arguments
    if (arguments is int) {
      foodID = arguments;
      await getFoodByID(foodID);
    } else if (arguments is List) {
      // arguments là list thì tranjg thái update
      isUpdate.value = true;

      // index 0 là foodID, 1 là Quantity
      foodID = arguments[0];
      double quantity = arguments[1];
      await getFoodByID(foodID);

      // gán giá trị cho calories và quantity
      calories.value = (quantity * foodModel.value.foodCalories!).toInt();
      this.quantity.value = quantity;

      // tách phần nguyên và phần thập phân của quantity
      int integerPart = quantity.toInt();
      double fractionalPart = quantity - integerPart;

      // gán phần nguyên cho quantitySelectedIndex
      quantitySelectedIndex.value = integerPart;

      // chuyển đổi phần thập phân thành Phân số
      String fractionString =
          FractionUtils.decimalToFractionString(fractionalPart);

      // kiểm tra phân số có thuộc list fraction, nếu không add thêm vào list
      if (fractionValues.contains(fractionString)) {
        fractionQuantitySelectedIndex.value =
            fractionValues.indexOf(fractionString);
      } else {
        fractionValues.add(fractionString);
        fractionQuantitySelectedIndex.value =
            fractionValues.indexOf(fractionString);
      }
    }

    isLoading.value = false;
  }

  Future<void> getFoodByID(int foodID) async {
    isLoading.value = true;
    http.Response response = await FoodRepository.getFoodByID(foodID);

    if (response.statusCode == 200) {
      // var data = json.decode();

      foodModel.value = FoodDetailsModel.fromJson(jsonDecode(response.body));
      foodTags.value = foodModel.value.foodTags!;
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    }
    isLoading.value = false;
  }

  Future<void> addMealLog() async {
    var mealController = Get.find<MealDetailsController>();
    MealLogModel mealLogModel = MealLogModel(
      foodID: foodModel.value.foodID,
      foodName: foodModel.value.foodName,
      calories: calories.value,
      quantity: quantity.value,
      unit: foodModel.value.serving,
      mealType: mealController.mealType.value.name,
    );

    mealController.createMealLogFromMealFoodDetails(mealLogModel);

    Get.back();
  }

  Future<void> updateMealLog() async {
    isLoading.value = true;
    var mealController = Get.find<MealDetailsController>();

    // tìm index hiện tại trong mealLogModels nếu tồn tại foodID
    int index =
        getIndexByFoodID(mealController.mealLogModels, foodModel.value.foodID!);
    // cập nhật giá trị mealLog tại index

    mealController.mealLogModels[index].calories = calories.value;
    mealController.mealLogModels[index].quantity = quantity.value;

    await mealController.updateMealLog(index);
    Get.back();
    isLoading.value = false;
    Get.snackbar("Update meal", "Update meal log success!");
  }
}
