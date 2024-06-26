import 'dart:convert';

List<MealLogRequest> mealLogRequestsFromJson(String str) =>
    List<MealLogRequest>.from(
        json.decode(str).map((x) => MealLogRequest.fromJson(x)));

String mealLogRequestToJson(List<MealLogRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealLogRequest {
  String? foodName;
  int? calories;
  String? mealType;
  double? quantity;
  String? unit;
  String? dateOfMeal;
  int? foodID;

  MealLogRequest({
    this.foodName,
    this.calories,
    this.mealType,
    this.quantity,
    this.unit,
    this.dateOfMeal,
    this.foodID,
  });

  factory MealLogRequest.fromJson(Map<String, dynamic> json) {
    return MealLogRequest(
      foodName: json['foodName'],
      calories: json['calories'],
      mealType: json['mealType'],
      quantity: json['quantity'],
      unit: json['unit'],
      dateOfMeal: json['dateOfMeal'],
      foodID: json['foodID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodName': foodName,
      'calories': calories,
      'mealType': mealType,
      'quantity': quantity,
      'unit': unit,
      'dateOfMeal': dateOfMeal,
      'foodID': foodID,
    };
  }
}
