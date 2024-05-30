// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

List<MemberModel> memberModelFromJson(String str) => List<MemberModel>.from(json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
    int? memberID;
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
        this.memberID,
        this.email,
        this.fullname,
        this.gender,
        this.phonenumber,
        this.height,
        this.weight,
        this.age,
        this.tdee,
        this.bmi,
        this.bmr,
    });

    factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        memberID: json["memberID"],
        email: json["email"],
        fullname: json["fullname"],
        gender: json["gender"],
        phonenumber: json["phonenumber"],
        height: json["height"],
        weight: json["weight"],
        age: json["age"],
        tdee: json["tdee"],
        bmi: json["bmi"],
        bmr: json["bmr"],
    );

    Map<String, dynamic> toJson() => {
        "memberID": memberID,
        "email": email,
        "fullname": fullname,
        "gender": gender,
        "phonenumber": phonenumber,
        "height": height,
        "weight": weight,
        "age": age,
        "tdee": tdee,
        "bmi": bmi,
        "bmr": bmr,
    };
}


