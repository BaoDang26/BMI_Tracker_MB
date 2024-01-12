// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/role_model.dart';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String registerMailToJson(UserModel data) {
  return json.encode(data.registerMailToJson());
}

class UserModel {
  String? userId;
  String? email;
  String? fullName;
  String? password;
  String? phoneNumber;
  String? certificateId;
  String? certificateName;
  String? status;
  String? roleId;
  RoleModel? roles;

  UserModel({
    this.userId,
    this.email,
    this.fullName,
    this.password,
    this.phoneNumber,
    this.certificateId,
    this.certificateName,
    this.status,
    this.roleId,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        email: json["email"],
        fullName: json["fullName"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        certificateId: json["certificateId"],
        certificateName: json["certificateName"],
        status: json["status"],
        roleId: json["roleId"],
        roles: json["roles"] == null ? null : RoleModel.fromJson(json["roles"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "fullName": fullName,
        "password": password,
        "phoneNumber": phoneNumber,
        "certificateId": certificateId,
        "certificateName": certificateName,
        "status": status,
        "roleId": roleId,
        "roles": roles?.toJson(),
      };

  Map<String, dynamic> registerMailToJson() => {
        // "username": username,
        "fullName": fullName,
        "email": email,
        "password": password,
      };
}
