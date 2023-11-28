// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

List<FoodModel> foodFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromMap(x)));

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
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foodId': foodId,
      'foodName': foodName,
      'foodTag': foodTag,
      'foodNutrition': foodNutrition,
      'foodNotes': foodNotes,
      'foodDescription': foodDescription,
      'foodPhoto': foodPhoto,
      'foodTimeProcess': foodTimeProcess,
      'foodCalories': foodCalories,
      'foodProcessingVideo': foodProcessingVideo,
      'categoryId': categoryId,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      foodId: map['foodId'] != null ? map['foodId'] as String : null,
      foodName: map['foodName'] != null ? map['foodName'] as String : null,
      foodTag: map['foodTag'] != null ? map['foodTag'] as String : null,
      foodNutrition:
          map['foodNutrition'] != null ? map['foodNutrition'] as String : null,
      foodNotes: map['foodNotes'] != null ? map['foodNotes'] as String : null,
      foodDescription: map['foodDescription'] != null
          ? map['foodDescription'] as String
          : null,
      foodPhoto: map['foodPhoto'] != null ? map['foodPhoto'] as String : null,
      foodTimeProcess:
          map['foodtimeProcess'] != null ? map['foodtimeProcess'] as int : null,
      foodCalories:
          map['foodCalories'] != null ? map['foodCalories'] as int : null,
      foodProcessingVideo: map['foodProcessingVideo'] != null
          ? map['foodProcessingVideo'] as String
          : null,
      categoryId:
          map['categoryId'] != null ? map['categoryId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
