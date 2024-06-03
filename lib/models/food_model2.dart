// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final foodModel = foodModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/recipe_model.dart';

List<FoodModel2> foodModelFromJson(String str) =>
    List<FoodModel2>.from(json.decode(str).map((x) => FoodModel2.fromJson(x)));

String foodModelToJson(List<FoodModel2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel2 {
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

  FoodModel2({
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

  factory FoodModel2.fromJson(Map<String, dynamic> json) => FoodModel2(
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
        recipes: json["recipes"] == null
            ? []
            : List<RecipeModel>.from(
                json["recipes"]!.map((x) => RecipeModel.fromJson(x))),
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

  @override
  String toString() {
    return 'FoodModel(foodId: $foodId, foodName: $foodName, foodTag: $foodTag, foodNutrition: $foodNutrition, foodNotes: $foodNotes, foodDesciption: $foodDesciption, foodPhoto: $foodPhoto, foodtimeProcess: $foodtimeProcess, foodCalorios: $foodCalorios, foodProcessingVideo: $foodProcessingVideo, status: $status, categoryId: $categoryId, categorys: $categorys, recipes: $recipes)';
  }
}

List<MenuFoodModel> menuFoodModelFromJson(String str) =>
    List<MenuFoodModel>.from(
        json.decode(str).map((x) => MenuFoodModel.fromJson(x)));

String menuFoodModelToJson(List<MenuFoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuFoodModel {
  final int foodID;
  final String foodName;
  final int foodCalories;
  final String description;
  final String foodPhoto;
  final String foodVideo;
  final int foodTimeProcess;
  final String creationDate;
  final bool isActive;

  MenuFoodModel({
    required this.foodID,
    required this.foodName,
    required this.foodCalories,
    required this.description,
    required this.foodPhoto,
    required this.foodVideo,
    required this.foodTimeProcess,
    required this.creationDate,
    required this.isActive,
  });

  factory MenuFoodModel.fromJson(Map<String, dynamic> json) {
    return MenuFoodModel(
      foodID: json['foodID'],
      foodName: json['foodName'],
      foodCalories: json['foodCalories'],
      description: json['description'],
      foodPhoto: json['foodPhoto'],
      foodVideo: json['foodVideo'],
      foodTimeProcess: json['foodTimeProcess'],
      creationDate: json['creationDate'],
      isActive: json['isActive'],
    );
  }

  static List<MenuFoodModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MenuFoodModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'foodID': foodID,
      'foodName': foodName,
      'foodCalories': foodCalories,
      'description': description,
      'foodPhoto': foodPhoto,
      'foodVideo': foodVideo,
      'foodTimeProcess': foodTimeProcess,
      'creationDate': creationDate,
      'isActive': isActive,
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<MenuFoodModel> foodList) {
    return foodList.map((food) => food.toJson()).toList();
  }
}
