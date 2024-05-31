import 'package:get/get.dart';

import '../models/meal_model2.dart';

class MealController extends GetxController {
  RxList<MealModel> mealModels = RxList.empty();

  @override
  void onInit() {
    print('Meal controller init');
    mealModels.add(new MealModel(
        mealType: 'Breakfast', currentCalories: 100, defaultCalories: 400));
    mealModels.add(new MealModel(
        mealType: 'Lunch', currentCalories: 100, defaultCalories: 600));
    mealModels.add(new MealModel(
        mealType: 'Dinner', currentCalories: 100, defaultCalories: 100));
    mealModels.add(new MealModel(
        mealType: 'Snack', currentCalories: 100, defaultCalories: 100));

    super.onInit();
  }
//   static const String mID = '3cd110f1-d22d-4ca1-81b8-39c8a1049733';
//   var foodList = <FoodModel>[].obs;
//   var foodListByMenuId = <FoodModel>[].obs;
//   // var ingredientList = <IngredientModel>[].obs;
//   var isLoading = true.obs;
//   final loginController = Get.put(LoginController());
//   var meals = <FoodModel>[].obs;
//   var menus = <MenuId>[].obs;

//   String menuId = '';

//   @override
//   void onInit() {
//     fetchFoods();
//     getFoodByMenu();
//     Timer.periodic(const Duration(seconds: 30), (timer) {
//       log("Getting new post every 30s");
//       getFoodByMenu();
//     });
//     super.onInit();
//   }

//   Future<void> fetchFoods() async {
//     var data = await FoodRepository.getAllFood();
//     if (data != null) {
//       foodList.value = foodModelFromJson(data);
//     }
//     isLoading.value = false;
//     update();
//   }

//   Future<void> getFoodByMenu() async {
//     var menuResponse = await UserRepository.getUserMenuId(
//         loginController.loginedUser.value.userId!.toString());

//     menus.value = menuIdFromJson(menuResponse);

//     log('Menu response: ${menus.toString()}');

//     if (menus == []) {
//       menuId = mID;
//     } else {
//       menuId = menus[0].menuId!;
//     }

//     var response = await MealRepository.getMealByMenuId(
//         'menu/foodByMenuId?menuId=$menuId');

//     log('response: ${response}');
//     if (response != null) {
//       meals.value = foodModelFromJson(response);
//       log('meals: ${meals.toString()}');
//     }
//     isLoading.value = false;
//     update();
//   }
}
