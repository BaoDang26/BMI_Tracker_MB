import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/enums/EMealType.dart';
import 'package:flutter_health_menu/models/food_model.dart';
import 'package:flutter_health_menu/repositories/daily_record_repository.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/meal/model/meal_log_request.dart';
import 'package:flutter_health_menu/screens/meal/widget/update_meal_log_widget.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/meal_log_model.dart';
import '../screens/meal/add_meal_log_screen.dart';

class MealDetailsController extends GetxController {
  RxList<MealLogModel> mealLogModels = RxList.empty();
  Rx<FoodModel> foodDetails = FoodModel.empty().obs;

  List<FoodModel> foodModels = List.empty();
  RxList<FoodModel> foodMenuModels = RxList.empty();
  late TextEditingController foodNameEditController;

  late TextEditingController caloriesEditController;

  late TextEditingController quantityEditController;

  late TextEditingController unitEditController;

  late String date;

  Rx<EMealType> mealType = EMealType.Snack.obs;
  int size = 8;

  final PagingController<int, FoodModel> pagingController =
      PagingController(firstPageKey: 0);

  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    // lấy dữ liệu cho mealDetails screen
    await fetchMealDetailsData();

    super.onInit();
  }

  Future<void> fetchMealDetailsData() async {
    isLoading.value = true;

    // lấy  date từ home controller qua arguments 0
    date = await Get.arguments[0];

    // lấy  mealType từ home controller qua arguments1
    mealType.value = await Get.arguments[1];

    // Lấy tất cả food được phân trang và có ưu tiên
    pagingController.addPageRequestListener((pageKey) async {
      await getAllFoodPaging(pageKey);
    });

    // Lấy danh danh sách MealLog theo Date và MealType
    await getAllMelLogOfDateByMealType();

    // Lấy danh sách Food trong Menu bằng MealType
    await getFoodsMenuByMealType();

    isLoading.value = false;
  }

  Future<void> getAllMelLogOfDateByMealType() async {
    // gọi API
    var response = await DailyRecordRepository.getAllMelLogOfDateByMealType(
        date, mealType.value.name);

    // kiểm tra response
    if (response.statusCode == 200) {
      // gán giá trị cho meal log model
      mealLogModels.value = mealLogModelsFromJson(response.body);
    } else if (response.statusCode == 204) {
      // Get.snackbar("No content", "");
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

  Future<void> createMealLogByForm() async {
    String foodName = foodNameEditController.text;
    // Giá trị mặc định là 0 nếu không thể chuyển đổi
    int calories = int.tryParse(caloriesEditController.text) ?? 0;
    // Giá trị mặc định là 'default_quantity' nếu chuỗi rỗng

    String quantity = quantityEditController.text.isNotEmpty
        ? quantityEditController.text
        : '0.0';
    // Giá trị mặc định là 'default_unit' nếu chuỗi rỗng
    String unit =
        unitEditController.text.isNotEmpty ? unitEditController.text : 'N/A';

    MealLogRequest mealLogRequest = MealLogRequest(
        mealType: mealType.value.name,
        calories: calories,
        foodName: foodName,
        quantity: double.parse(quantity),
        unit: unit,
        dateOfMeal: date);
    var response = await DailyRecordRepository.createMealLog(mealLogRequest);

    if (response.statusCode == 201) {
      // 201 create thành công, convert kết quả với Meal log model
      MealLogModel mealLogModel =
          MealLogModel.fromJson(jsonDecode(response.body));

      // thêm meal log mới vào list hiện tại
      mealLogModels.add(mealLogModel);

      // quay trở lại mà hình Meal log sau khi create thành cng
      Get.back();

      // tạo thông báo thành công
      Get.snackbar("Add new meal", "Add to meal log success!");
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

  Future<void> createMealLogByFood(FoodModel foodCreateMeal) async {
    // tìm địa chỉ hiện tại trong mealLogModels nếu tồn tại foodID
    int index = getIndexByFoodID(mealLogModels, foodCreateMeal.foodID);
    print("createMealLogByFood: ${index}");
    if (index > -1) {
      // nếu đã tồn tại cập nhật lại giá trị meal log
      // vì add toàn bộ khẩu phaafn ăn nên mặc định quantity =1
      MealLogModel mealLogModel = mealLogModels.elementAt(index);
      mealLogModel.calories =
          mealLogModel.calories! + foodCreateMeal.foodCalories;
      mealLogModel.quantity = mealLogModel.quantity! + 1;
      mealLogModels[index] = mealLogModel;
      updateMealLog(index);
    } else {
      MealLogRequest mealLogRequest = MealLogRequest(
          mealType: mealType.value.name,
          calories: foodCreateMeal.foodCalories,
          foodName: foodCreateMeal.foodName,
          quantity: 1,
          unit: foodCreateMeal.serving,
          dateOfMeal: date,
          foodID: foodCreateMeal.foodID);

      // không tồn tại gọi DailyRecordRepository tạo mới MealLog
      var response = await DailyRecordRepository.createMealLog(mealLogRequest);

      if (response.statusCode == 201) {
        // 201 create thành công, convert kết quả với Meal log model
        MealLogModel mealLogModel =
            MealLogModel.fromJson(jsonDecode(response.body));

        // thêm meal log mới vào list hiện tại
        mealLogModels.add(mealLogModel);

        // tạo thông báo thành công
        // Get.snackbar("Add new meal", "Add to meal log success!");
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
  }

  Future<void> createMealLogFromMealFoodDetails(
      MealLogModel mealLogCreate) async {
    // tìm địa chỉ hiện tại trong mealLogModels nếu tồn tại foodID
    int index = getIndexByFoodID(mealLogModels, mealLogCreate.foodID!);

    if (index > -1) {
      // nếu đã tồn tại cập nhật lại giá trị meal log
      MealLogModel mealLogModel = mealLogModels.elementAt(index);
      mealLogModel.calories = mealLogModel.calories! + mealLogCreate.calories!;

      mealLogModel.quantity = mealLogModel.quantity! + mealLogCreate.quantity!;

      mealLogModels[index] = mealLogModel;
      updateMealLog(index);
    } else {
      MealLogRequest mealLogRequest = MealLogRequest(
          mealType: mealType.value.name,
          calories: mealLogCreate.calories,
          foodName: mealLogCreate.foodName,
          quantity: mealLogCreate.quantity,
          unit: mealLogCreate.unit,
          dateOfMeal: date,
          foodID: mealLogCreate.foodID);

      // không tồn tại gọi DailyRecordRepository tạo mới MealLog
      var response = await DailyRecordRepository.createMealLog(mealLogRequest);

      if (response.statusCode == 201) {
        // 201 create thành công, convert kết quả với Meal log model
        MealLogModel mealLogModel =
            MealLogModel.fromJson(jsonDecode(response.body));

        // thêm meal log mới vào list hiện tại
        mealLogModels.add(mealLogModel);

        // tạo thông báo thành công
        Get.snackbar("Add new meal", "Add to meal log success!");
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
  }

  Future<void> getFoodsMenuByMealType() async {
    var response =
        await MemberRepository.getMenuByMealType(mealType.value.name);
    if (response.statusCode == 200) {
      // convert list foods from json
      foodMenuModels.value = foodModelsFromJson(response.body);
    } else if (response.statusCode == 204) {
      print('list empty');
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

  Future<void> getAllFoodPaging(int pageKey) async {
    try {
      var response = await MemberRepository.getAllFoodWithPaging(pageKey, size);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['foods'] != null) {
          // Parse food items from the response
          foodModels = foodModelsPagingFromJson(response.body);
        }

        final isLastPage = data['last'] as bool;
        if (isLastPage) {
          pagingController.appendLastPage(foodModels);
        } else {
          pagingController.appendPage(foodModels, pageKey + 1);
        }
      } else if (response.statusCode == 401) {
        String message = jsonDecode(response.body)['message'];
        if (message.contains("JWT token is expired")) {
          Get.snackbar('Session Expired', 'Please login again');
        }
      } else {
        Get.snackbar("Error server ${response.statusCode}",
            json.decode(response.body)['message']);
      }
    } catch (error) {
      print('vvvvvvvvvvv:${error.toString()}');
      pagingController.error = error;
    }
  }

  Future<void> removeMealLog(int index) async {
    var response = await DailyRecordRepository.deleteMealLogByID(
        mealLogModels[index].mealLogID);

    if (response.statusCode == 204) {
      Get.snackbar("Delete", "Delete meal log success");

      // xóa item trong list khi thành công
      mealLogModels.removeAt(index);
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

  Future<void> updateMealLog(int index) async {
    // nhận giá trị mealLog đã đưuọc cập nhật tại index
    MealLogModel mealLogModel = mealLogModels[index];
    print('mealLogModel:${mealLogModel.toString()}');
    // tạo mealLogUpdate
    Map<String, String> mealLogUpdate = {
      'mealLogID': mealLogModel.mealLogID.toString(),
      'calories': mealLogModel.calories.toString(),
      'quantity': mealLogModel.quantity.toString()
    };

    var response = await DailyRecordRepository.updateMealLog(mealLogUpdate);
    if (response.statusCode == 200) {
      Get.snackbar("Update meal", "Update meal log success!");
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

  void updateMealLogByForm(int index) {
    String foodName = foodNameEditController.text;
    int calories = int.parse(caloriesEditController.text);
    double quantity = double.parse(quantityEditController.text);
    String unit = unitEditController.text;

    MealLogModel mealLogModel = mealLogModels[index];
    mealLogModel.foodName = foodName;
    mealLogModel.calories = calories;
    mealLogModel.quantity = quantity;
    mealLogModel.unit = unit;

    updateMealLog(index);
    mealLogModels[index] = mealLogModel;
    Get.back();
  }

  void goToUpdateMealLog(int index) {
    // lấy giá trị meal log từ vị trí index
    MealLogModel mealLogModel = mealLogModels[index];

    // kiểm tra có tồn tại food ID
    if (mealLogModel.foodID == null) {
      // nếu foodID null thì trả về form edit

      foodNameEditController = TextEditingController();
      foodNameEditController.text = mealLogModel.foodName ?? '';
      caloriesEditController = TextEditingController();
      caloriesEditController.text = mealLogModel.calories.toString();

      quantityEditController = TextEditingController();
      quantityEditController.text = mealLogModel.quantity.toString();

      unitEditController = TextEditingController();
      unitEditController.text = mealLogModel.unit ?? '';

      Get.to(() => UpdateMealLogWidget(index));
    } else {
      // ngược lại trả về màn hình mealFoodDetails
      Get.toNamed(AppRoutes.mealLogFoodDetailsScreen,
          arguments: [mealLogModel.foodID, mealLogModel.quantity]);
    }
  }

  void goToFoodDetails(FoodModel foodModel) {
    Get.toNamed(AppRoutes.mealLogFoodDetailsScreen,
        arguments: foodModel.foodID);
  }

  void goToAddMealLog() {
    foodNameEditController = TextEditingController();
    caloriesEditController = TextEditingController();
    quantityEditController = TextEditingController();
    unitEditController = TextEditingController();
    Get.to(() => const AddMealLogScreen());
  }


  void selectAction(String result) {
    switch (result) {
      case "Chart":
        Get.toNamed(AppRoutes.statisticsCaloriesScreen, arguments: date);
        break;
      case "Custom entry meal":
        goToAddMealLog();
        break;
    }
  }
}
