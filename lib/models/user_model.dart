import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String registerToJson(UserModel data) {
  return json.encode(data.registerToJson());
}

String registerMailToJson(UserModel data) {
  return json.encode(data.registerMailToJson());
}

String updateToJson(UserModel data) {
  return json.encode(data.updateToJson());
}

class UserModel extends Equatable {
  UserModel({
    this.id,
    this.isProve,
    this.proveImageUrl,
    this.fullname,
    this.password,
    this.gender,
    this.dateOfBirth,
    this.avatarUrl,
    this.isAdmin = false,
    this.isActive = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.v = 0,
  })  : this.createdAt = createdAt ?? DateTime.now(),
        this.updatedAt = updatedAt ?? DateTime.now();

  final String? id;
  final bool? isProve;
  final String? proveImageUrl;
  final String? fullname;
  final String? password;
  final String? gender;
  final String? dateOfBirth;
  final String? avatarUrl;
  final bool isAdmin;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? v;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        isProve: json["is_prove"],
        proveImageUrl: json["proveImage_url"],
        // username: json["username"],
        fullname: json["fullname"],
        password: json["password"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        avatarUrl: json["avatar_url"],
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  factory UserModel.isProveFromModel(Map<String, dynamic> json) => UserModel(
        isProve: json["is_prove"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "password": password,
        "gender": gender,
        // "friends": List<dynamic>.from(friends!.map((x) => x)),
        "date_of_birth": dateOfBirth,
        "avatar_url": avatarUrl,
        "is_admin": isAdmin,
        "is_active": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };

  Map<String, dynamic> registerToJson() => {
        "fullname": fullname,
        "password": password,
        "gender": gender,
        "date_of_birth": dateOfBirth,
      };
  Map<String, dynamic> registerMailToJson() => {
        "fullname": fullname,
        "password": password,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "proveImage_url": proveImageUrl,
        "is_prove": isProve,
      };

  Map<String, dynamic> updateToJson() => {
        "fullname": fullname,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "avatar_url": avatarUrl,
      };

  @override
  List<Object?> get props {
    return [
      id,
      fullname,
      password,
      gender,
      dateOfBirth,
      avatarUrl,
      isAdmin,
      isActive,
      createdAt,
      updatedAt,
      v,
    ];
  }
}
