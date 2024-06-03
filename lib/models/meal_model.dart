// To parse this JSON data, do
//
//     final mealModel = mealModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/food_model2.dart';
import 'package:flutter_health_menu/models/menu_model.dart';

List<MealModel> mealModelFromJson(String str) =>
    List<MealModel>.from(json.decode(str).map((x) => MealModel.fromJson(x)));

String mealModelToJson(List<MealModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealModel {
  String? menuId;
  String? foodId;
  FoodModel2? foods;
  MenuModel? menus;

  MealModel({
    this.menuId,
    this.foodId,
    this.foods,
    this.menus,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        menuId: json["menuId"],
        foodId: json["foodId"],
        foods:
            json["foods"] == null ? null : FoodModel2.fromJson(json["foods"]),
        menus: json["menus"] == null ? null : MenuModel.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "foodId": foodId,
        "foods": foods?.toJson(),
        "menus": menus?.toJson(),
      };
}
