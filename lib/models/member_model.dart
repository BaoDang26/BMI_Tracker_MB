import 'dart:convert';

import 'package:flutter_health_menu/util/app_export.dart';
import 'package:intl/intl.dart';

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
  String? dietaryPreference;
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
    this.dietaryPreference,
    this.bmi,
    this.bmr,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    String date = json['birthday'] ?? "1900-05-01";
    String endDate = json["endDateOfPlan"] ?? '1900-05-01';

    return MemberModel(
      accountID: json["accountID"],
      memberID: json["memberID"],
      email: json["email"],
      accountPhoto: json["accountPhoto"] ??
          'https://res.cloudinary.com/dlipvbdwi/image/upload/v1705123226/Capstone/avatar_default_zhjqey.jpg',
      fullName: json["fullName"],
      gender: json["gender"],
      phoneNumber: json["phoneNumber"],
      endDateOfPlan:
          DateTimeExtension.parseWithFormat(endDate, format: "yyyy-MM-dd"),
      birthday: DateTimeExtension.parseWithFormat(date, format: "yyyy-MM-dd"),
      height: json["height"],
      weight: json["weight"],
      targetWeight: json["targetWeight"],
      age: json["age"],
      tdee: json["tdee"],
      dietaryPreference: json["dietaryPreference"],
      bmi: json["bmi"],
      bmr: json["bmr"],
    );
  }

  Map<String, dynamic> toJson() => {
        "accountID": accountID,
        "memberID": memberID,
        "accountPhoto": accountPhoto,
        "email": email,
        "fullName": fullName,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "endDateOfPlan": endDateOfPlan!.format("yyyy-MM-dd"),
        "birthday": birthday!.format("yyyy-MM-dd"),
        "height": height,
        "weight": weight,
        "targetWeight": targetWeight,
        "age": age,
        "tdee": tdee,
        "dietaryPreference": dietaryPreference,
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
