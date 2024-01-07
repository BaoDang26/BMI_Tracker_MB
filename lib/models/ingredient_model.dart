// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

List<IngredientModel> ingredientFromJson(String str) =>
    List<IngredientModel>.from(
        json.decode(str).map((x) => IngredientModel.fromJson(x)));

String ingredientToJson(IngredientModel ingredient) =>
    json.encode(ingredient.toJson());

class IngredientModel extends Equatable {
  final String? ingredientId;
  final String? ingredientName;
  final String? ingredientPhoto;
  final String? status;
  final String? categoryId;

  const IngredientModel({
    this.ingredientId,
    this.ingredientName,
    this.ingredientPhoto,
    this.status,
    this.categoryId,
  });

  @override
  List<Object?> get props {
    return [
      ingredientId,
      ingredientName,
      ingredientPhoto,
      status,
      categoryId,
    ];
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      ingredientId:
          json['ingredientId'] != null ? json['ingredientId'] as String : null,
      ingredientName: json['ingredientName'] != null
          ? json['ingredientName'] as String
          : null,
      ingredientPhoto: json['ingredientPhoto'] != null
          ? json['ingredientPhoto'] as String
          : null,
      status: json['status'] != null ? json['status'] as String : null,
      categoryId:
          json['categoryId'] != null ? json['categoryId'] as String : null,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'ingredientId': ingredientId,
  //     'ingredientName': ingredientName,
  //     'ingredientPhoto': ingredientPhoto,
  //     'categoryId': categoryId,
  //   };
  // }

  Map<String, dynamic> toJson() => {
        // "created_by": createdBy == null ? null : createdBy!.toJson(),
        "ingredientId": ingredientId == null ? null : ingredientId,
        "ingredientName": ingredientName == null ? null : ingredientName,
        "ingredientPhoto": ingredientPhoto == null ? null : ingredientPhoto,
        "status": status == null ? null : status,
        "categoryId": categoryId == null ? null : categoryId,
        // "foodCalories": foodCalories == null ? null : foodCalories,
        // "foodProcessingVideo":
        //     foodProcessingVideo == null ? null : foodProcessingVideo,
        // "categoryId": categoryId == null ? null : categoryId,
        // "foodNutrition": foodNutrition == null ? null : foodNutrition,
      };

  // String toJson() => json.encode(toMap());

  // factory IngredientModel.fromJson(String source) =>
  //     IngredientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // bool get stringify => true;
}
