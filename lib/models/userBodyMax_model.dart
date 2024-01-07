// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_health_menu/models/role_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';

// List<UserBodyMaxModel> userBodyMaxFromJson(String str) =>
//     List<UserBodyMaxModel>.from(
//         json.decode(str).map((x) => UserBodyMaxModel.fromJson(x)));

List<UserBodyMaxModel> userbodymaxFromJson(String str) =>
    List<UserBodyMaxModel>.from(
        json.decode(str).map((x) => UserBodyMaxModel.fromJson(x)));

// String userBodyMaxToJson(List<UserBodyMaxModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// String userBodyMaxToJson(UserBodyMaxModel data) => json.encode(data.toMap());

String registerBodyMaxToJson(UserBodyMaxModel registUserBodyMax) =>
    json.encode(registUserBodyMax.toJson());

// String updateToJson(UserModel data) {
//   return json.encode(data.updateToJson());
// }

class UserBodyMaxModel extends Equatable {
  final String? userInfoId;
  final String? height;
  final String? weight;
  final String? age;
  final String? bmiPerson;
  final String? bmr;
  // final Role? roles;
  final String? sex;
  final UserModel? createdBy;

  // UserBodyMaxModel value;

  const UserBodyMaxModel({
    this.userInfoId,
    this.height,
    this.weight,
    this.age,
    this.bmiPerson,
    this.bmr,
    this.sex,
    this.createdBy,

    // this.age,
  });

  @override
  List<Object?> get props {
    return [
      userInfoId,
      height,
      weight,
      age,
      bmiPerson,
      bmr,
      sex,
      createdBy,
      // age,
    ];
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'userInfoId': userInfoId,
  //     'height': height,
  //     'weight': weight,
  //     'age': age,
  //     'bmiPerson': bmiPerson,
  //     'bmr': bmr,
  //     'sex': sex,
  //     'createdBy': createdBy!.toMap(),
  //     // 'age': age,
  //   };
  // }

  // factory UserBodyMaxModel.fromMap(Map<String, dynamic> map) {
  //   return UserBodyMaxModel(
  //     // userInfoId: map['userInfoId'] as String,
  //     height: map['height'] as String,
  //     weight: map['weight'] as String,
  //     age: map['age'] as String,
  //     bmiPerson: map['bmiPerson'] as String,
  //     bmr: map['bmr'] as String,
  //     sex: map['sex'] as String,
  //     // createdBy: UserModel.fromMap(map['createdBy']),
  //     createdBy: UserModel.fromMap(map['createdBy'] as Map<String, dynamic>),
  //   );
  // }

  factory UserBodyMaxModel.fromJson(Map<String, dynamic> json) =>
      UserBodyMaxModel(
        userInfoId: json["userInfoId"],
        height: json["height"],
        weight: json["weight"],
        age: json["age"],
        bmiPerson: json["bmiPerson"],
        bmr: json["bmr"],
        sex: json["sex"],
        createdBy: UserModel.fromJson(json["userId"]),
      );

  // String toJson() => json.encode(toMap());

  Map<String, dynamic> toJson() => {
        'userInfoId': userInfoId,
        'height': height,
        'weight': weight,
        'age': age,
        'bmiPerson': bmiPerson,
        'bmr': bmr,
        'sex': sex,
        'createdBy': createdBy!.toJson(),
      };

  // factory UserBodyMaxModel.fromJson(String source) =>
  //     UserBodyMaxModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
