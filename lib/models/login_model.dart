import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
