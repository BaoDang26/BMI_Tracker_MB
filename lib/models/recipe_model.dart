import 'dart:convert';

List<RecipeModel> recipeModelsFromJson(String str) => List<RecipeModel>.from(
    json.decode(str).map((x) => RecipeModel.fromJson(x)));

String recipeModelToJson(List<RecipeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeModel {
  int? ingredientID;
  String? ingredientName;
  String? ingredientPhoto;
  double? quantity;
  String? unit;
  bool? isActive;

  RecipeModel({
    this.ingredientID,
    this.ingredientName,
    this.ingredientPhoto,
    this.quantity,
    this.unit,
    this.isActive,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      ingredientID: json['ingredientID'],
      ingredientName: json['ingredientName'],
      ingredientPhoto: json['ingredientPhoto'],
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: json['unit'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientID': ingredientID,
      'ingredientName': ingredientName,
      'ingredientPhoto': ingredientPhoto,
      'quantity': quantity,
      'unit': unit,
      'isActive': isActive,
    };
  }
}
