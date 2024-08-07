import 'dart:convert';

List<FoodModel> foodModelsFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

List<FoodModel> foodModelsPagingFromJson(String str) => List<FoodModel>.from(
    json.decode(str)["foods"].map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  int? foodID;
  String? foodName;
  int? foodCalories;
  String? description;
  String? foodPhoto;
  String? foodVideo;
  int? foodTimeProcess;
  double? carbs;
  double? protein;
  double? fat;
  int? serving;
  String? creationDate;
  bool? isActive;

  FoodModel({
    this.foodID,
    this.foodName,
    this.foodCalories,
    this.description,
    this.foodPhoto,
    this.foodVideo,
    this.foodTimeProcess,
    this.carbs,
    this.protein,
    this.fat,
    this.serving,
    this.creationDate,
    this.isActive,
  });

  FoodModel.empty()
      : foodID = 0,
        foodName = '',
        foodCalories = 0,
        description = '',
        foodPhoto = '',
        foodVideo = '',
        foodTimeProcess = 0,
        carbs = 0,
        protein = 0,
        fat = 0,
        serving = 0,
        creationDate = '',
        isActive = false;

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodID: json['foodID'],
      foodName: json['foodName'],
      foodCalories: json['foodCalories'],
      description: json['description'] ?? '',
      foodPhoto: json['foodPhoto'] ?? '',
      foodVideo: json['foodVideo'] ?? '',
      foodTimeProcess: json['foodTimeProcess'],
      carbs: json['carbs'],
      protein: json['protein'],
      fat: json['fat'],
      serving: json['serving'],
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
      'foodTimeProcess': foodTimeProcess,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'serving': serving,
      'creationDate': creationDate,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return 'FoodModel{foodID: $foodID, foodName: $foodName, foodCalories: $foodCalories, description: $description, foodPhoto: $foodPhoto, foodVideo: $foodVideo, serving: $serving,foodTimeProcess: $foodTimeProcess, carbs: $carbs, protein: $protein, fat: $fat, creationDate: $creationDate, isActive: $isActive}';
  }
}
