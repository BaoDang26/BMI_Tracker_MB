// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_health_menu/models/role_model.dart';

class UserModel extends Equatable {
  final String? userId;
  final String? email;
  final String? fullname;
  final String? password;
  final String? sex;
  final String? phoneNumber;
  final Role? roles;

  const UserModel({
    this.userId,
    this.email,
    this.fullname,
    this.password,
    this.sex,
    this.phoneNumber,
    this.roles,
  });

  @override
  List<Object?> get props {
    return [
      userId,
      email,
      fullname,
      password,
      sex,
      phoneNumber,
      roles,
    ];
  }

  UserModel copyWith({
    String? userId,
    String? email,
    String? fullname,
    String? password,
    String? sex,
    String? phoneNumber,
    Role? roles,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      password: password ?? this.password,
      sex: sex ?? this.sex,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'fullname': fullname,
      'password': password,
      'sex': sex,
      'phoneNumber': phoneNumber,
      'roles': roles!.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      email: map['email'] as String,
      fullname: map['fullName'] as String,
      password: map['password'] as String,
      sex: map['sex'] as String,
      phoneNumber: map['phoneNumber'] as String,
      roles: Role.fromMap(map['roles'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
