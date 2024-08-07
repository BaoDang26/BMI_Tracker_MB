// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/util/app_export.dart';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) =>
    json.encode(data.toJson());

class UpdateProfileModel {
  String? fullName;
  String? phoneNumber;
  String? accountPhoto;
  String? gender;
  DateTime? birthday;

  UpdateProfileModel({
    this.fullName,
    this.phoneNumber,
    this.accountPhoto,
    this.gender,
    this.birthday,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        accountPhoto: json["accountPhoto"],
        gender: json["gender"],
        birthday: DateTime.parse(json["birthday"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "accountPhoto": accountPhoto,
        "gender": gender,
        "birthday": birthday!.format(),
      };
}
