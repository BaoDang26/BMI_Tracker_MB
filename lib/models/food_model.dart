// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_health_menu/models/ingredient_model.dart';
import 'package:flutter_health_menu/models/menu_model.dart';

List<FoodModel> foodFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodToJson(FoodModel food) => json.encode(food.toJson());

class FoodModel extends Equatable {
  final String? foodId;
  final String? foodName;
  final String? foodTag;
  final String? foodNutrition;
  final String? foodNotes;
  final String? foodDescription;
  final String? foodPhoto;
  final int? foodTimeProcess;
  final int? foodCalories;
  final String? foodProcessingVideo;
  final String? categoryId;
  final List<IngredientModel> ingredients;

  const FoodModel({
    this.foodId,
    this.foodName,
    this.foodTag,
    this.foodNutrition,
    this.foodNotes,
    this.foodDescription,
    this.foodPhoto,
    this.foodTimeProcess,
    this.foodCalories,
    this.foodProcessingVideo,
    this.categoryId,
    required this.ingredients,
  });

  @override
  List<Object?> get props {
    return [
      foodId,
      foodName,
      foodTag,
      foodNutrition,
      foodNotes,
      foodDescription,
      foodPhoto,
      foodTimeProcess,
      foodCalories,
      foodProcessingVideo,
      categoryId,
      ingredients,
    ];
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        foodId: json['foodId'] != null ? json['foodId'] as String : null,
        foodName: json['foodName'] != null ? json['foodName'] as String : null,
        foodTag: json['foodTag'] != null ? json['foodTag'] as String : null,
        foodNutrition: json['foodNutrition'] != null
            ? json['foodNutrition'] as String
            : null,
        foodNotes:
            json['foodNotes'] != null ? json['foodNotes'] as String : null,
        foodDescription: json['foodDescription'] != null
            ? json['foodDescription'] as String
            : null,
        foodPhoto:
            json['foodPhoto'] != null ? json['foodPhoto'] as String : null,
        foodTimeProcess: json['foodtimeProcess'] != null
            ? json['foodtimeProcess'] as int
            : null,
        foodCalories:
            json['foodCalorios'] != null ? json['foodCalorios'] as int : null,
        foodProcessingVideo: json['foodProcessingVideo'] != null
            ? json['foodProcessingVideo'] as String
            : null,
        categoryId:
            json['categoryId'] != null ? json['categoryId'] as String : null,
        ingredients: List<IngredientModel>.from(
            json["recipes"].map((x) => IngredientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "created_by": createdBy == null ? null : createdBy!.toJson(),
        // "foodId": foodId == null ? null : foodId,
        "foodName": foodName == null ? null : foodName,
        "foodNutrition": foodNutrition == null ? null : foodNutrition,
        "foodDescription": foodDescription == null ? null : foodDescription,
        "foodPhoto": foodPhoto == null ? null : foodPhoto,
        "foodTimeProcess": foodTimeProcess == null ? null : foodTimeProcess,
        "foodCalorios": foodCalories == null ? null : foodCalories,
        "foodProcessingVideo":
            foodProcessingVideo == null ? null : foodProcessingVideo,
        // "categoryId": categoryId == null ? null : categoryId,
        "recipes": ingredients == null
            ? null
            : List<IngredientModel>.from(ingredients!.map((x) => x.toJson())),
        // "foodNutrition": foodNutrition == null ? null : foodNutrition,
      };

  // String toJson() => json.encode(toMap());

  // factory FoodModel.fromJson(String source) =>
  //     FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // bool get stringify => true;
}
