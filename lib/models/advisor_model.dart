// To parse this JSON data, do
//
//     final advisorModel = advisorModelFromJson(jsonString);

import 'dart:convert';

List<AdvisorModel> advisorModelFromJson(String str) => List<AdvisorModel>.from(json.decode(str).map((x) => AdvisorModel.fromJson(x)));

String advisorModelToJson(List<AdvisorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvisorModel {
    String? linkPhoto;
    String? email;
    String? fullName;
    String? phoneNumber;
    String? gender;
    DateTime? birthday;

    AdvisorModel({
        this.linkPhoto,
        this.email,
        this.fullName,
        this.phoneNumber,
        this.gender,
        this.birthday,
    });

    factory AdvisorModel.fromJson(Map<String, dynamic> json) => AdvisorModel(
        linkPhoto: json["linkPhoto"],
        email: json["email"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        birthday: DateTime.parse(json["birthday"]),
    );

    Map<String, dynamic> toJson() => {
        "linkPhoto": linkPhoto,
        "email": email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "birthday": "${birthday?.year.toString().padLeft(4, '0')}-${birthday?.month.toString().padLeft(2, '0')}-${birthday?.day.toString().padLeft(2, '0')}",
    };
}
