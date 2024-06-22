import 'dart:convert';

import 'package:flutter_health_menu/models/enums/EMealType.dart';

List<MealLogModel> mealLogModelsFromJson(String str) => List<MealLogModel>.from(
    json.decode(str).map((x) => MealLogModel.fromJson(x)));

String mealLogModelToJson(List<MealLogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

int getIndexByFoodID(List<MealLogModel> mealLogModels, int foodID) {
  return mealLogModels.indexWhere((mealLog) => mealLog.foodID == foodID);
}

class MealLogModel {
  int? mealLogID;
  String? foodName;
  int? calories;
  String? mealType;
  double? quantity;
  int? recordID;
  int? foodID;

  MealLogModel({
    this.mealLogID,
    this.foodName,
    this.calories,
    this.mealType,
    this.quantity,
    this.recordID,
    this.foodID,
  });

  factory MealLogModel.fromJson(Map<String, dynamic> json) {
    return MealLogModel(
      mealLogID: json['mealLogID'],
      foodName: json['foodName'],
      calories: json['calories'],
      mealType: json['mealType'],
      quantity: (json['quantity'] as num?)?.toDouble(),
      recordID: json['recordID'],
      foodID: json['foodID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealLogID': mealLogID,
      'foodName': foodName,
      'calories': calories,
      'mealType': mealType,
      'quantity': quantity,
      'recordID': recordID,
      'foodID': foodID,
    };
  }
}
