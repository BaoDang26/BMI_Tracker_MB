class MealModel {
  String? mealType;
  int? currentCalories;
  int? defaultCalories;

  MealModel({
    this.mealType,
    this.currentCalories,
    this.defaultCalories,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      mealType: json['mealType'],
      currentCalories: json['currentCalories'],
      defaultCalories: json['defaultCalories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType,
      'currentCalories': currentCalories,
      'defaultCalories': defaultCalories,
    };
  }

  static List<MealModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MealModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<MealModel> mealList) {
    return mealList.map((meal) => meal.toJson()).toList();
  }
}