// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/food_model2.dart';
import 'package:flutter_health_menu/models/ingredient_model.dart';

List<RecipeModel> recipeModelFromJson(String str) => List<RecipeModel>.from(
    json.decode(str).map((x) => RecipeModel.fromJson(x)));

String recipeModelToJson(List<RecipeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeModel {
  String? ingredientId;
  String? foodId;
  FoodModel2? foods;
  IngredientModel? ingredients;

  RecipeModel({
    this.ingredientId,
    this.foodId,
    this.foods,
    this.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        ingredientId: json["ingredientId"],
        foodId: json["foodId"],
        foods: json["foods"] == null ? null : FoodModel2.fromJson(json["foods"]),
        ingredients: json["ingredients"] == null
            ? null
            : IngredientModel.fromJson(json["ingredients"]),
      );

  Map<String, dynamic> toJson() => {
        "ingredientId": ingredientId,
        "foodId": foodId,
        "foods": foods?.toJson(),
        "ingredients": ingredients?.toJson(),
      };
}
