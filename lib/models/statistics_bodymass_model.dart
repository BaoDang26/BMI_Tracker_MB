import 'dart:convert';

class StatisticsMemberBodyMassModel {
  int? memberBodyMassID;
  int? height;
  int? weight;
  int? age;
  double? bmi;
  DateTime? dateInput;

  StatisticsMemberBodyMassModel({
    this.memberBodyMassID,
    this.height,
    this.weight,
    this.age,
    this.bmi,
    this.dateInput,
  });

  factory StatisticsMemberBodyMassModel.fromJson(Map<String, dynamic> json) {
    return StatisticsMemberBodyMassModel(
      memberBodyMassID: json['memberBodyMassID'],
      height: json['height'],
      weight: json['weight'],
      age: json['age'],
      bmi: json['bmi'],
      dateInput:
          json['dateInput'] != null ? DateTime.parse(json['dateInput']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberBodyMassID': memberBodyMassID,
      'height': height,
      'weight': weight,
      'age': age,
      'bmi': bmi,
      'dateInput': dateInput?.toIso8601String(),
    };
  }

  static List<StatisticsMemberBodyMassModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => StatisticsMemberBodyMassModel.fromJson(json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<StatisticsMemberBodyMassModel> records) {
    return records.map((record) => record.toJson()).toList();
  }
}

List<StatisticsMemberBodyMassModel> statisticsMemberBodyMassFromJson(String str) {
  List<StatisticsMemberBodyMassModel> list = List<StatisticsMemberBodyMassModel>.from(
      json.decode(str).map((x) => StatisticsMemberBodyMassModel.fromJson(x)));

  // Sort the list by dateInput in descending order
  list.sort((a, b) => a.dateInput!.compareTo(b.dateInput!));

  return list;
}

String statisticsMemberBodyMassToJson(
    List<StatisticsMemberBodyMassModel> data) {
  final jsonData = StatisticsMemberBodyMassModel.toJsonList(data);
  return json.encode(jsonData);
}
