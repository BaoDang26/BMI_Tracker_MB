import 'dart:convert';

import 'package:flutter_health_menu/util/app_export.dart';

List<MemberModel> memberModelsFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelsToJson(List<MemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
  int? accountID;
  int? memberID;
  String? email;
  String? accountPhoto;
  String? fullName;
  String? gender;
  String? phoneNumber;
  DateTime? endDateOfPlan;
  DateTime? birthday;
  int? height;
  int? weight;
  int? targetWeight;
  int? age;
  double? tdee;
  double? bmi;
  double? bmr;

  MemberModel({
    this.accountID,
    this.memberID,
    this.accountPhoto,
    this.email,
    this.fullName,
    this.gender,
    this.phoneNumber,
    this.endDateOfPlan,
    this.birthday,
    this.height,
    this.weight,
    this.targetWeight,
    this.age,
    this.tdee,
    this.bmi,
    this.bmr,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        accountID: json["accountID"],
        memberID: json["memberID"],
        email: json["email"],
        accountPhoto: json["accountPhoto"] ??
            'https://res.cloudinary.com/dlipvbdwi/image/upload/v1705123226/Capstone/avatar_default_zhjqey.jpg',
        fullName: json["fullName"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        endDateOfPlan: DateTime.parse(json["endDateOfPlan"] ?? "1900-01-01"),
        birthday: DateTime.parse(json["birthday"]),
        height: json["height"],
        weight: json["weight"],
        targetWeight: json["targetWeight"],
        age: json["age"],
        tdee: json["tdee"],
        bmi: json["bmi"],
        bmr: json["bmr"],
      );

  Map<String, dynamic> toJson() => {
        "accountID": accountID,
        "memberID": memberID,
        "accountPhoto": accountPhoto,
        "email": email,
        "fullName": fullName,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "endDateOfPlan": endDateOfPlan!.format(),
        "birthday": getBirthday(),
        "height": height,
        "weight": weight,
        "targetWeight": targetWeight,
        "age": age,
        "tdee": tdee,
        "bmi": bmi,
        "bmr": bmr,
      };

  String getBirthday() {
    DateTime.now().format;
    String date = birthday?.format() ?? '1900-01-01';
    return date;
  }

  @override
  String toString() {
    return 'MemberModel{accountID: $accountID,  memberID: $memberID, email: $email,'
        ' accountPhoto: $accountPhoto, '
        'fullName: $fullName, gender: $gender, '
        'phoneNumber: $phoneNumber,'
        'endDateOfPlan: $endDateOfPlan,'
        'birthday: $birthday,'
        ' height: $height, weight: $weight, age: $age, tdee: $tdee, bmi: $bmi, bmr: $bmr}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          memberID == other.memberID;

  @override
  int get hashCode => email.hashCode ^ memberID.hashCode;
}
