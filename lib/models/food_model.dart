import 'dart:convert';

List<FoodModel> foodModelsFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  int? foodID;
  String? foodName;
  int? foodCalories;
  String? description;
  String? foodPhoto;
  String? foodVideo;
  String? foodNutrition;
  int? foodTimeProcess;
  String? creationDate;
  bool? isActive;

  FoodModel({
    this.foodID,
    this.foodName,
    this.foodCalories,
    this.description,
    this.foodPhoto,
    this.foodVideo,
    this.foodNutrition,
    this.foodTimeProcess,
    this.creationDate,
    this.isActive,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodID: json['foodID'],
      foodName: json['foodName'],
      foodCalories: json['foodCalories'],
      description: json['description'],
      foodPhoto: json['foodPhoto'],
      foodVideo: json['foodVideo'],
      foodNutrition: json['foodNutrition'],
      foodTimeProcess: json['foodTimeProcess'],
      creationDate: json['creationDate'],
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
      'foodNutrition': foodNutrition,
      'foodTimeProcess': foodTimeProcess,
      'creationDate': creationDate,
      'isActive': isActive,
    };
  }
}
