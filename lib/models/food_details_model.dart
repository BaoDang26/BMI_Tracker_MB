import 'dart:convert';

import 'package:flutter_health_menu/models/food_tag_basic_model.dart';
import 'package:flutter_health_menu/models/ingredient_model.dart';

class FoodDetailsModel {
  int? foodID;
  String? foodName;
  int? foodCalories;
  String? description;
  String? foodPhoto;
  String? foodVideo;
  String? foodNutrition;
  int? foodTimeProcess;
  String? creationDate;
  List<FoodTag>? foodTags;
  List<Ingredient>? ingredients;
  bool? active;

  FoodDetailsModel({
    this.foodID,
    this.foodName,
    this.foodCalories,
    this.description,
    this.foodPhoto,
    this.foodVideo,
    this.foodNutrition,
    this.foodTimeProcess,
    this.creationDate,
    this.foodTags,
    this.ingredients,
    this.active,
  });

  factory FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    return FoodDetailsModel(
      foodID: json['foodID'],
      foodName: json['foodName'],
      foodCalories: json['foodCalories'],
      description: json['description'],
      foodPhoto: json['foodPhoto'],
      foodVideo: json['foodVideo'],
      foodNutrition: json['foodNutrition'],
      foodTimeProcess: json['foodTimeProcess'],
      creationDate: json['creationDate'],
      foodTags: json['foodTags'] != null
          ? List<FoodTag>.from(json['foodTags'].map((x) => FoodTag.fromJson(x)))
          : null,
      ingredients: json['ingredients'] != null
          ? List<Ingredient>.from(
              json['ingredients'].map((x) => Ingredient.fromJson(x)))
          : null,
      active: json['active'],
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
      'foodNutrition': foodNutrition,
      'foodTimeProcess': foodTimeProcess,
      'creationDate': creationDate,
      'foodTags': foodTags != null
          ? List<dynamic>.from(foodTags!.map((x) => x.toJson()))
          : null,
      'ingredients': ingredients != null
          ? List<dynamic>.from(ingredients!.map((x) => x.toJson()))
          : null,
      'active': active,
    };
  }

  @override
  String toString() {
    return 'FoodDetailsModel{foodID: $foodID, foodName: $foodName, foodCalories: $foodCalories, description: $description, foodPhoto: $foodPhoto, foodVideo: $foodVideo, foodNutrition: $foodNutrition, foodTimeProcess: $foodTimeProcess, creationDate: $creationDate, foodTags: $foodTags, ingredients: $ingredients, active: $active}';
  }
}

// Functions to parse and serialize JSON
List<FoodDetailsModel> foodModelsFromJson(String str) =>
    List<FoodDetailsModel>.from(json.decode(str).map((x) => FoodDetailsModel.fromJson(x)));

String foodModelToJson(List<FoodDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
