// To parse this JSON data, do
//
//     final ingredientModel = ingredientModelFromJson(jsonString);

import 'dart:convert';

List<IngredientModel> ingredientModelFromJson(String str) =>
    List<IngredientModel>.from(
        json.decode(str).map((x) => IngredientModel.fromJson(x)));

String ingredientModelToJson(List<IngredientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IngredientModel {
  String? ingredientId;
  String? ingredientName;
  String? ingredientPhoto;
  String? status;
  // dynamic recipes;
  String? categoryId;
  // dynamic categorys;

  IngredientModel({
    this.ingredientId,
    this.ingredientName,
    this.ingredientPhoto,
    this.status,
    // this.recipes,
    this.categoryId,
    // this.categorys,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        ingredientId: json["ingredientId"],
        ingredientName: json["ingredientName"],
        ingredientPhoto: json["ingredientPhoto"],
        status: json["status"],
        // recipes: json["recipes"],
        categoryId: json["categoryId"],
        // categorys: json["categorys"],
      );

  Map<String, dynamic> toJson() => {
        "ingredientId": ingredientId,
        "ingredientName": ingredientName,
        "ingredientPhoto": ingredientPhoto,
        "status": status,
        // "recipes": recipes,
        "categoryId": categoryId,
        // "categorys": categorys,
      };
}
