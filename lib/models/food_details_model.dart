import 'dart:convert';

import 'package:flutter_health_menu/models/food_tag_basic_model.dart';
import 'package:flutter_health_menu/models/recipe_model.dart';

class FoodDetailsModel {
  int? foodID;
  String? foodName;
  int? foodCalories;
  String? description;
  String? foodPhoto;
  String? foodVideo;
  int? foodTimeProcess;
  double? carbs;
  double? protein;
  double? fat;
  String? creationDate;
  int? serving;
  List<FoodTag>? foodTags;
  List<RecipeModel>? recipes;
  bool? isActive;

  FoodDetailsModel({
    this.foodID,
    this.foodName,
    this.foodCalories,
    this.description,
    this.foodPhoto,
    this.foodVideo,
    this.foodTimeProcess,
    this.carbs,
    this.protein,
    this.fat,
    this.creationDate,
    this.serving,
    this.foodTags,
    this.recipes,
    this.isActive,
  });

  factory FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    return FoodDetailsModel(
      foodID: json['foodID'],
      foodName: json['foodName'],
      foodCalories: json['foodCalories'],
      description: json['description'],
      foodPhoto: json['foodPhoto'],
      foodVideo: json['foodVideo'],
      serving: json['serving'] ?? '2 serving',
      carbs: json['carbs'],
      protein: json['protein'],
      fat: json['fat'],
      foodTimeProcess: json['foodTimeProcess'],
      creationDate: json['creationDate'],
      foodTags: json['foodTags'] != null
          ? List<FoodTag>.from(json['foodTags'].map((x) => FoodTag.fromJson(x)))
          : null,
      recipes: json['recipes'] != null
          ? List<RecipeModel>.from(
              json['recipes'].map((x) => RecipeModel.fromJson(x)))
          : null,
      isActive: json['isActive'],
    );
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
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'serving': serving,
      'creationDate': creationDate,
      'foodTags': foodTags != null
          ? List<dynamic>.from(foodTags!.map((x) => x.toJson()))
          : null,
      'recipes': recipes != null
          ? List<dynamic>.from(recipes!.map((x) => x.toJson()))
          : List.empty(),
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return 'FoodDetailsModel{foodID: $foodID,'
        ' foodName: $foodName, foodCalories:'
        ' $foodCalories, description: $description,'
        ' foodPhoto: $foodPhoto, foodVideo: $foodVideo, '
        'carbs: $carbs, protein: $protein, fat: $fat,  foodTimeProcess: '
        '$foodTimeProcess, serving: $serving, creationDate:'
        ' $creationDate, foodTags: $foodTags, ingredients: $recipes,'
        ' isActive: $isActive}';
  }
}

// Functions to parse and serialize JSON
List<FoodDetailsModel> foodDetailsModelsFromJson(String str) =>
    List<FoodDetailsModel>.from(
        json.decode(str).map((x) => FoodDetailsModel.fromJson(x)));

String foodDetailsModelToJson(List<FoodDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<FoodDetailsModel> foodDetailsModelsPagingFromJson(String str) =>
    List<FoodDetailsModel>.from(
        json.decode(str)["foods"].map((x) => FoodDetailsModel.fromJson(x)));
