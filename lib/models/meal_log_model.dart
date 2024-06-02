import 'dart:convert';

List<MealLogModel> mealLogModelsFromJson(String str) =>
    List<MealLogModel>.from(json.decode(str).map((x) => MealLogModel.fromJson(x)));

String mealLogModelToJson(List<MealLogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealLogModel {
  int? mealLogID;
  String? foodName;
  int? calories;
  String? mealType;
  String? quantity;
  int? recordID;

  MealLogModel({
    this.mealLogID,
    this.foodName,
    this.calories,
    this.mealType,
    this.quantity,
    this.recordID,
  });

  factory MealLogModel.fromJson(Map<String, dynamic> json) {
    return MealLogModel(
      mealLogID: json['mealLogID'],
      foodName: json['foodName'],
      calories: json['calories'],
      mealType: json['mealType'],
      quantity: json['quantity'],
      recordID: json['recordID'],
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
    };
  }
}
