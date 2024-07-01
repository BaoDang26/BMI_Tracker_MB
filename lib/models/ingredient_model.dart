
class Ingredient {
  int? ingredientID;
  String? ingredientName;
  String? ingredientPhoto;
  double? quantity;
  String? unitOfMeasurement;
  int? ingredientCalories;
  int? tagID;
  bool? isActive;

  Ingredient({
    this.ingredientID,
    this.ingredientName,
    this.ingredientPhoto,
    this.quantity,
    this.unitOfMeasurement,
    this.ingredientCalories,
    this.tagID,
    this.isActive,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientID: json['ingredientID'],
      ingredientName: json['ingredientName'],
      ingredientPhoto: json['ingredientPhoto'],
      quantity: json['quantity'].toDouble(),
      unitOfMeasurement: json['unit'],
      ingredientCalories: json['ingredientCalories'],
      tagID: json['tagID'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientID': ingredientID,
      'ingredientName': ingredientName,
      'ingredientPhoto': ingredientPhoto,
      'quantity': quantity,
      'unit': unitOfMeasurement,
      'ingredientCalories': ingredientCalories,
      'tagID': tagID,
      'isActive': isActive,
    };
  }
}
