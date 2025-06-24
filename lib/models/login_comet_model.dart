// To parse this JSON data, do
//
//     final loginCometModel = loginCometModelFromJson(jsonString);

import 'dart:convert';

LoginCometModel loginCometModelFromJson(String str) =>
    LoginCometModel.fromJson(json.decode(str));

String loginCometModelToJson(LoginCometModel data) =>
    json.encode(data.toJson());

class LoginCometModel {
  int? accountID;
  int? memberId;
  String? email;
  String? fullName;
  String? gender;
  String? phoneNumber;
  int? height;
  int? weight;
  int? age;
  String? refreshToken;
  String? accessToken;
  double? bmi;
  double? bmr;
  double? tdee;

  LoginCometModel({
    this.accountID,
    this.memberId,
    this.email,
    this.fullName,
    this.gender,
    this.phoneNumber,
    this.height,
    this.weight,
    this.age,
    this.refreshToken,
    this.accessToken,
    this.bmi,
    this.bmr,
    this.tdee,
  });

  factory LoginCometModel.fromJson(Map<String, dynamic> json) =>
      LoginCometModel(
        accountID: json["accountID"],
        memberId: json["memberID"],
        email: json["email"],
        fullName: json["fullName"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        height: json["height"],
        weight: json["weight"],
        age: json["age"],
        refreshToken: json["refreshToken"],
        accessToken: json["accessToken"],
        bmi: json["bmi"],
        bmr: json["bmr"],
        tdee: json["tdee"],
      );

  Map<String, dynamic> toJson() => {
        "accountID": accountID,
        "memberID": memberId,
        "email": email,
        "fullName": fullName,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "height": height,
        "weight": weight,
        "age": age,
        "refreshToken": refreshToken,
        "accessToken": accessToken,
        "bmi": bmi,
        "bmr": bmr,
        "tdee": tdee,
      };
}
