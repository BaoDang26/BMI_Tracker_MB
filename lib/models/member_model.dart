// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

List<MemberModel> memberModelFromJson(String str) => List<MemberModel>.from(json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
    int? memberId;
    String? email;
    String? fullname;
    String? gender;
    String? phonenumber;
    int? height;
    int? weight;
    int? age;
    String? activityLevel;
    double? tdee;
    double? bmi;
    double? bmr;

    MemberModel({
        this.memberId,
        this.email,
        this.fullname,
        this.gender,
        this.phonenumber,
        this.height,
        this.weight,
        this.age,
        this.activityLevel,
        this.tdee,
        this.bmi,
        this.bmr,
    });

    factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        memberId: json["memberId"],
        email: json["email"],
        fullname: json["fullname"],
        gender: json["gender"],
        phonenumber: json["phonenumber"],
        height: json["height"],
        weight: json["weight"],
        age: json["age"],
        activityLevel: json["activityLevel"],
        tdee: json["tdee"],
        bmi: json["bmi"],
        bmr: json["bmr"],
    );

    Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "email": email,
        "fullname": fullname,
        "gender": gender,
        "phonenumber": phonenumber,
        "height": height,
        "weight": weight,
        "age": age,
        "activityLevel": activityLevel,
        "tdee": tdee,
        "bmi": bmi,
        "bmr": bmr,
    };
}


