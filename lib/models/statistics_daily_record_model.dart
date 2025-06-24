import 'dart:convert';

class StatisticsDailyRecordModel {
  int? recordID;
  int? totalCaloriesIn;
  int? totalCaloriesOut;
  int? defaultCalories;
  DateTime? date;

  StatisticsDailyRecordModel({
    this.recordID,
    this.totalCaloriesIn,
    this.totalCaloriesOut,
    this.defaultCalories,
    this.date,
  });

  factory StatisticsDailyRecordModel.fromJson(Map<String, dynamic> json) {
    return StatisticsDailyRecordModel(
      recordID: json['recordID'],
      totalCaloriesIn: json['totalCaloriesIn'],
      totalCaloriesOut: json['totalCaloriesOut'],
      defaultCalories: json['defaultCalories'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recordID': recordID,
      'totalCaloriesIn': totalCaloriesIn,
      'totalCaloriesOut': totalCaloriesOut,
      'defaultCalories': defaultCalories,
      'date': date?.toIso8601String(),
    };
  }

  static List<StatisticsDailyRecordModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => StatisticsDailyRecordModel.fromJson(json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<StatisticsDailyRecordModel> records) {
    return records.map((record) => record.toJson()).toList();
  }
}

List<StatisticsDailyRecordModel> statisticsDailyRecordsFromJson(String str) {
  final jsonData = json.decode(str);
  return StatisticsDailyRecordModel.fromJsonList(jsonData);
}

String statisticsDailyRecordsToJson(List<StatisticsDailyRecordModel> data) {
  final jsonData = StatisticsDailyRecordModel.toJsonList(data);
  return json.encode(jsonData);
}
