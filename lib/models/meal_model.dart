// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_health_menu/models/menu_model.dart';

// import '../models/food_model.dart';

// List<MealModel> mealFromJson(String str) =>
//     List<MealModel>.from(json.decode(str).map((x) => MealModel.fromMap(x)));

// class MealModel extends Equatable {
//   final String menuId;
//   final String foodId;
//   final FoodModel? foods;
//   final MenuModel? menus;

//   const MealModel({
//     required this.menuId,
//     required this.foodId,
//     required this.foods,
//     required this.menus,
//   });

//   @override
//   List<Object?> get props {
//     return [
//       menuId,
//       foodId,
//       foods,
//       // password,
//       // // sex,
//       // phoneNumber,
//       // roles,
//       // age,
//     ];
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'menuId': menuId,
//       'foodId': foodId,
//       'foods': foods!.toMap(),
//     };
//   }

//   factory MealModel.fromMap(Map<String, dynamic> map) {
//     return MealModel(
//       menuId: map['menuId'] as String,
//       foodId: map['foodId'] as String,
//       foods: FoodModel.fromMap(map['foods'] as Map<String, dynamic>),
//       menus: MenuModel.fromMap(map['foods'] as Map<String, dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MealModel.fromJson(String source) =>
//       MealModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   bool get stringify => true;
// }
