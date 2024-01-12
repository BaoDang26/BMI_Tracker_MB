// To parse this JSON data, do
//
//     final foodModel = foodModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/recipe_model.dart';

List<FoodModel> foodModelFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  String? foodId;
  String? foodName;
  String? foodTag;
  String? foodNutrition;
  String? foodNotes;
  String? foodDesciption;
  String? foodPhoto;
  int? foodtimeProcess;
  int? foodCalorios;
  String? foodProcessingVideo;
  String? status;
  String? categoryId;
  dynamic categorys;
  List<RecipeModel>? recipes;
  // List<Meal>? meals;

  FoodModel({
    this.foodId,
    this.foodName,
    this.foodTag,
    this.foodNutrition,
    this.foodNotes,
    this.foodDesciption,
    this.foodPhoto,
    this.foodtimeProcess,
    this.foodCalorios,
    this.foodProcessingVideo,
    this.status,
    this.categoryId,
    this.categorys,
    this.recipes,
    // this.meals,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        foodId: json["foodId"],
        foodName: json["foodName"],
        foodTag: json["foodTag"],
        foodNutrition: json["foodNutrition"],
        foodNotes: json["foodNotes"],
        foodDesciption: json["foodDesciption"],
        foodPhoto: json["foodPhoto"],
        foodtimeProcess: json["foodtimeProcess"],
        foodCalorios: json["foodCalorios"],
        foodProcessingVideo: json["foodProcessingVideo"],
        status: json["status"],
        categoryId: json["categoryId"],
        categorys: json["categorys"],
        recipes: List<RecipeModel>.from(
            json["recipes"].map((x) => RecipeModel.fromJson(x))),
        // meals: json["meals"] == null ? [] : List<Meal>.from(json["meals"]!.map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "foodName": foodName,
        "foodTag": foodTag,
        "foodNutrition": foodNutrition,
        "foodNotes": foodNotes,
        "foodDesciption": foodDesciption,
        "foodPhoto": foodPhoto,
        "foodtimeProcess": foodtimeProcess,
        "foodCalorios": foodCalorios,
        "foodProcessingVideo": foodProcessingVideo,
        "status": status,
        "categoryId": categoryId,
        "categorys": categorys,
        // "recipes": recipes == null ? [] : List<dynamic>.from(recipes!.map((x) => x.toJson())),
        // "meals": meals == null ? [] : List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}
