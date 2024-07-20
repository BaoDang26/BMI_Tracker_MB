// met_calculator.dart

class MetCalculator {
  /// Tính số calo tiêu thụ mỗi phút dựa trên METs, trọng lượng cơ thể và thời gian.
  ///
  /// [mets]: Giá trị MET của hoạt động.
  /// [weightKg]: Trọng lượng cơ thể của người dùng tính bằng kilogram.
  /// [minutes]: Thời gian thực hiện hoạt động tính bằng phút.
  ///
  /// Trả về số calo tiêu thụ.
  static int calculateCaloriesBurned(
      double met, int weightKg, int duration) {
    // Công thức tính số calo tiêu thụ mỗi phút
    double caloriesPerMinute = met * 3.5 * weightKg / 200;

    // Tính tổng số calo tiêu thụ
    return (caloriesPerMinute * duration).round();
  }
}
