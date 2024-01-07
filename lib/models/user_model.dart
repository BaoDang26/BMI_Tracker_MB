// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_health_menu/models/role_model.dart';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

// String userToJson(List<UserModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// String registerToJson(UserModel data) {
//   return json.encode(data.registerToJson());
// }
// String loginToJson(LoginModel data) => json.encode(data.toJson());

// String registerMailToJson(UserModel data) {
//   return json.encode(data.registerMailToJson());
// }

String registerMailToJson(UserModel data) => json.encode(data.toJson());

// String updateToJson(UserModel data) {
//   return json.encode(data.updateToJson());
// }

class UserModel extends Equatable {
  final String? userId;
  final String? email;
  final String? fullname;
  final String? password;
  // final String? sex;
  final String? phoneNumber;
  final Role? roles;
  // final String? age;

  const UserModel({
    this.userId,
    this.email,
    this.fullname,
    this.password,
    // this.sex,
    this.phoneNumber,
    this.roles,
    // this.age,
  });

  @override
  List<Object?> get props {
    return [
      userId,
      email,
      fullname,
      password,
      // sex,
      phoneNumber,
      roles,
      // age,
    ];
  }

  // UserModel copyWith({
  //   String? userId,
  //   String? email,
  //   String? fullname,
  //   String? password,
  //   // String? sex,
  //   String? phoneNumber,
  //   Role? roles,
  //   // String? age,
  // }) {
  //   return UserModel(
  //     userId: userId ?? this.userId,
  //     email: email ?? this.email,
  //     fullname: fullname ?? this.fullname,
  //     password: password ?? this.password,
  //     // sex: sex ?? this.sex,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     roles: roles ?? this.roles,
  //     // age: age ?? this.age,
  //   );
  // }

  // Map<String, dynamic> registerMailToJson() => {
  //       "email": email,
  //       "fullname": fullname,
  //       "password": password,
  //       // "sex": sex,
  //       // "date_of_birth": dateOfBirth,
  //       // "proveImage_url": proveImageUrl,
  //       // "is_prove": isProve,
  //     };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      fullname: json['fullName'] as String,
      password: json['password'] as String,
      // sex: map['sex'] as String,
      // age: map['age'] as String,
      phoneNumber: json['phoneNumber'] as String,
      // roles: Role.fromMap(map['roles'] as Map<String, dynamic>),
    );
  }

  // String toJson() => json.encode(toMap());
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'fullname': fullname,
        'password': password,
        'phoneNumber': phoneNumber,
      };

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // bool get stringify => true;
}
