import 'dart:convert';

List<FoodModel> foodModelsFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

List<FoodModel> foodModelsPagingFromJson(String str) => List<FoodModel>.from(
    json.decode(str)["foods"].map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  int foodID;
  String foodName;
  int foodCalories;
  String description;
  String foodPhoto;
  String foodVideo;
  String foodNutrition;
  String serving;
  int foodTimeProcess;
  String creationDate;
  bool isActive;

  FoodModel({
    required this.foodID,
    required this.foodName,
    required this.foodCalories,
    required this.description,
    required this.foodPhoto,
    required this.foodVideo,
    required this.foodNutrition,
    required this.foodTimeProcess,
    required this.serving,
    required this.creationDate,
    required this.isActive,
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
      serving: json['serving'],
      creationDate: json['creationDate'],
      isActive: json['active'],
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
      'serving': serving,
      'creationDate': creationDate,
      'active': isActive,
    };
  }

  @override
  String toString() {
    return 'FoodModel{foodID: $foodID, foodName: $foodName, foodCalories: $foodCalories, description: $description, foodPhoto: $foodPhoto, foodVideo: $foodVideo, foodNutrition: $foodNutrition, foodTimeProcess: $foodTimeProcess, creationDate: $creationDate, isActive: $isActive}';
  }
}
