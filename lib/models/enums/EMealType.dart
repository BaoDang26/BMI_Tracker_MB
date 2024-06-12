enum EMealType { Breakfast, Lunch, Dinner, Snack }

extension EMealTypeExtension on EMealType {
  static EMealType fromString(String mealType) {
    switch (mealType) {
      case 'Breakfast':
        return EMealType.Breakfast;
      case 'Lunch':
        return EMealType.Lunch;
      case 'Dinner':
        return EMealType.Dinner;
      case 'Snack':
        return EMealType.Snack;
      default:
        throw Exception('Invalid meal type: $mealType');
    }
  }

  String get name {
    switch (this) {
      case EMealType.Breakfast:
        return 'Breakfast';
      case EMealType.Lunch:
        return 'Lunch';
      case EMealType.Dinner:
        return 'Dinner';
      case EMealType.Snack:
        return 'Snack';
    }
  }
}
