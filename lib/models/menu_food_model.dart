import 'dart:convert';

List<MenuFoodModel> menuFoodModelFromJson(String str) =>
    List<MenuFoodModel>.from(
        json.decode(str).map((x) => MenuFoodModel.fromJson(x)));

String menuFoodModelToJson(List<MenuFoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuFoodModel {
  final int foodID;
  final String foodName;
  final int foodCalories;
  final String description;
  final String foodPhoto;
  final String foodVideo;
  final String foodNutrition;
  final int foodTimeProcess;
  final String serving;
  final String creationDate;
  final bool isActive;

  MenuFoodModel({
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

  factory MenuFoodModel.fromJson(Map<String, dynamic> json) {
    return MenuFoodModel(
      foodID: json['foodID'],
      foodName: json['foodName'],
      foodCalories: json['foodCalories'],
      description: json['description'],
      foodPhoto: json['foodPhoto'],
      foodVideo: json['foodVideo'],
      foodNutrition: json['foodNutrition'],
      serving: json['serving'],
      foodTimeProcess: json['foodTimeProcess'],
      creationDate: json['creationDate'],
      isActive: json['active'],
    );
  }

  static List<MenuFoodModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MenuFoodModel.fromJson(json)).toList();
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
      'serving': serving,
      'foodTimeProcess': foodTimeProcess,
      'creationDate': creationDate,
      'active': isActive,
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<MenuFoodModel> foodList) {
    return foodList.map((food) => food.toJson()).toList();
  }
}
