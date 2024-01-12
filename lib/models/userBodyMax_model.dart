// To parse this JSON data, do
//
//     final userBodyMaxModel = userBodyMaxModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/user_model.dart';

List<UserBodyMaxModel> userBodyMaxModelFromJson(String str) =>
    List<UserBodyMaxModel>.from(
        json.decode(str).map((x) => UserBodyMaxModel.fromJson(x)));

String userBodyMaxModelToJson(List<UserBodyMaxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String registUserBodyMaxToJson(UserBodyMaxModel data) {
  return json.encode(data.registUserBodyMaxToJson());
}

class UserBodyMaxModel {
  String? userInfoId;
  int? heght;
  int? weight;
  int? age;
  double? bmiPerson;
  double? bmr;
  double? tdee;
  int? sex;
  String? status;
  DateTime? dateInput;
  String? userId;
  UserModel? users;
  // List<Schedule>? schedules;
  dynamic orders;

  UserBodyMaxModel({
    this.userInfoId,
    this.heght,
    this.weight,
    this.age,
    this.bmiPerson,
    this.bmr,
    this.tdee,
    this.sex,
    this.status,
    this.dateInput,
    this.userId,
    this.users,
    // this.schedules,
    this.orders,
  });

  factory UserBodyMaxModel.fromJson(Map<String, dynamic> json) =>
      UserBodyMaxModel(
        userInfoId: json["userInfoId"] == null ? null : json["userInfoId"],
        heght: json["heght"],
        weight: json["weight"],
        age: json["age"],
        bmiPerson: json["bmiPerson"]?.toDouble(),
        bmr: json["bmr"]?.toDouble(),
        tdee: json["tdee"]?.toDouble(),
        sex: json["sex"],
        status: json["status"],
        dateInput: json["dateInput"] == null
            ? null
            : DateTime.parse(json["dateInput"]),
        userId: json["userId"],
        users: json["users"] == null ? null : UserModel.fromJson(json["users"]),
        // schedules: json["schedules"] == null ? [] : List<Schedule>.from(json["schedules"]!.map((x) => Schedule.fromJson(x))),
        orders: json["orders"],
      );

  Map<String, dynamic> toJson() => {
        "userInfoId": userInfoId,
        "heght": heght,
        "weight": weight,
        "age": age,
        "bmiPerson": bmiPerson,
        "bmr": bmr,
        "tdee": tdee,
        "sex": sex,
        "status": status,
        "dateInput": dateInput?.toIso8601String(),
        "userId": userId,
        "users": users?.toJson(),
        // "schedules": schedules == null ? [] : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        "orders": orders,
      };

  Map<String, dynamic> registUserBodyMaxToJson() => {
        "heght": heght,
        "weight": weight,
        "age": age,
        "sex": sex,
        "userId": userId,
      };

  // Map<String, dynamic> toMap() => {
  //   "heght": heght,
  //   "weight": weight,
  //   "age": age,
  //   "sex": sex,
  //   "userId": userId,
  //   "userBodyMaxMenus":
  //       List<dynamic>.from(userBodyMaxMenus.map((x) => x.toMap())),
  // };
}
