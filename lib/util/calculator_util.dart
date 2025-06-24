// met_calculator.dart

class CalculatorUtil {
  /// Tính số calo tiêu thụ mỗi phút dựa trên METs, trọng lượng cơ thể và thời gian.
  ///
  /// [mets]: Giá trị MET của hoạt động.
  /// [weightKg]: Trọng lượng cơ thể của người dùng tính bằng kilogram.
  /// [minutes]: Thời gian thực hiện hoạt động tính bằng phút.
  ///
  /// Trả về số calo tiêu thụ.
  static int calculateCaloriesBurned(double met, int weightKg, int duration) {
    // Công thức tính số calo tiêu thụ mỗi phút
    double caloriesPerMinute = met * 3.5 * weightKg / 200;

    // Tính tổng số calo tiêu thụ
    return (caloriesPerMinute * duration).round();
  }

  static double calculateBMI(double weight, double height) {
    if (height <= 0) return 0;
    return weight / (height * height);
  }

  static double calculateStrBMI(String strWeight, String strHeight) {
    //weight (kg)
    int weight = int.parse(strWeight);
    // height (m)
    double height = int.parse(strHeight) / 100;
    if (height <= 0) return 0;
    return weight / (height * height);
  }

  // height (m)
  static double calculateMinTargetWeight(double height) {
    // giá trị bmi nhỏ nhất
    double minBmi = 18.5;
    return minBmi * height * height;
  }

  // height (m)
  static double calculateMaxTargetWeight(double height) {
    // giá trị bmi lớn nhất
    double maxBmi = 24.9;
    return maxBmi * height * height;
  }
}
