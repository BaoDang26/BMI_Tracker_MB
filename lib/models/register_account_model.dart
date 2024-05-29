// To parse this JSON data, do
//
//     final registerAccountModel = registerAccountModelFromJson(jsonString);

import 'dart:convert';

RegisterAccountModel registerAccountModelFromJson(String str) => RegisterAccountModel.fromJson(json.decode(str));

String registerAccountModelToJson(RegisterAccountModel data) => json.encode(data.toJson());

class RegisterAccountModel {
    String? fullName;
    String? email;
    String? phoneNumber;
    String? password;
    String? gender;
    DateTime? birthday;

    RegisterAccountModel({
        this.fullName,
        this.email,
        this.phoneNumber,
        this.password,
        this.gender,
        this.birthday,
    });

    factory RegisterAccountModel.fromJson(Map<String, dynamic> json) => RegisterAccountModel(
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        gender: json["gender"],
        birthday: DateTime.parse(json["birthday"]),
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "gender": gender,
        "birthday": "${birthday?.year.toString().padLeft(4, '0')}-${birthday?.month.toString().padLeft(2, '0')}-${birthday?.day.toString().padLeft(2, '0')}",
    };
}
