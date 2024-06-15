
import 'dart:convert';

import 'package:flutter_health_menu/models/enums/EMealType.dart';

List<MealModel> mealModelsFromJson(String str) =>
    List<MealModel>.from(
        json.decode(str).map((x) => MealModel.fromJson(x)));

String mealModelToJson(List<MealModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class MealModel {
  EMealType? mealType;
  int? currentCalories;
  int? defaultCalories;

  MealModel({
    this.mealType,
    this.currentCalories,
    this.defaultCalories,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      mealType: EMealTypeExtension.fromString(json['mealType']),
      currentCalories: json['currentCalories'],
      defaultCalories: json['defaultCalories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType,
      'currentCalories': currentCalories,
      'defaultCalories': defaultCalories,
    };
  }

  static List<MealModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MealModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<MealModel> mealList) {
    return mealList.map((meal) => meal.toJson()).toList();
  }
}