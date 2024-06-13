import 'dart:convert';

List<DailyRecordModel> dailyRecordModelsFromJson(String str) =>
    List<DailyRecordModel>.from(json.decode(str).map((x) => DailyRecordModel.fromJson(x)));

String dailyRecordModelToJson(List<DailyRecordModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyRecordModel {
  int? recordID;
  int? totalCaloriesIn;
  int? totalCaloriesOut;
  int? defaultCalories;
  String? date;

  DailyRecordModel({
    this.recordID,
    this.totalCaloriesIn,
    this.totalCaloriesOut,
    this.defaultCalories,
    this.date,
  });

  factory DailyRecordModel.fromJson(Map<String, dynamic> json) {
    return DailyRecordModel(
      recordID: json['recordID'],
      totalCaloriesIn: json['totalCaloriesIn'],
      totalCaloriesOut: json['totalCaloriesOut'],
      defaultCalories: json['defaultCalories'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recordID': recordID,
      'totalCaloriesIn': totalCaloriesIn,
      'totalCaloriesOut': totalCaloriesOut,
      'defaultCalories': defaultCalories,
      'date': date,
    };
  }
}
