// To parse this JSON data, do
//
//     final memberBodyMassModel = memberBodyMassModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/member_model.dart';

List<MemberBodyMassModel> memberBodyMassModelFromJson(String str) {
  List<MemberBodyMassModel> list = List<MemberBodyMassModel>.from(
      json.decode(str).map((x) => MemberBodyMassModel.fromJson(x)));

  // Sort the list by dateInput in descending order
  list.sort((a, b) => a.dateInput!.compareTo(b.dateInput!));

  return list;
}

String memberBodyMassModelToJson(List<MemberBodyMassModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberBodyMassModel {
  int? memberBodyMassId;
  int? height;
  int? weight;
  int? age;
  double? bmi;
  DateTime? dateInput;

  // MemberModel? member;

  MemberBodyMassModel({
    this.memberBodyMassId,
    this.height,
    this.weight,
    this.age,
    this.bmi,
    this.dateInput,
    // this.member,
  });

  factory MemberBodyMassModel.fromJson(Map<String, dynamic> json) =>
      MemberBodyMassModel(
        memberBodyMassId: json["memberBodyMassID"],
        height: json["height"],
        weight: json["weight"],
        age: json["age"],
        bmi: json["bmi"].toDouble(),
        dateInput: DateTime.parse(json["dateInput"]),
        // member: MemberModel.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "memberBodyMassID": memberBodyMassId,
        "height": height,
        "weight": weight,
        "age": age,
        "bmi": bmi,
        "dateInput": dateInput?.toIso8601String(),
        // "member": member?.toJson(),
      };

  @override
  String toString() {
    return 'MemberBodyMassModel{memberBodyMassId: $memberBodyMassId, height: $height, weight: $weight, age: $age, bmi: $bmi, dateInput: $dateInput}';
  }
}

// class ActivityLevel {
//     int activityLevelId;
//     String activityLevelName;
//     bool active;
//     double activityLevel;

//     ActivityLevel({
//         this.activityLevelId,
//         this.activityLevelName,
//         this.active,
//         this.activityLevel,
//     });

//     factory ActivityLevel.fromJson(Map<String, dynamic> json) => ActivityLevel(
//         activityLevelId: json["activityLevelID"],
//         activityLevelName: json["activityLevelName"],
//         active: json["active"],
//         activityLevel: json["activityLevel"].toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "activityLevelID": activityLevelId,
//         "activityLevelName": activityLevelName,
//         "active": active,
//         "activityLevel": activityLevel,
//     };
// }
