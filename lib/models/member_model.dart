import 'dart:convert';

List<MemberModel> memberModelsFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
  int? memberID;
  String? email;
  String? fullName;
  String? gender;
  String? phoneNumber;
  int? height;
  int? weight;
  int? age;
  double? tdee;
  double? bmi;
  double? bmr;

  MemberModel({
    this.memberID,
    this.email,
    this.fullName,
    this.gender,
    this.phoneNumber,
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
        fullName: json["fullName"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
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
        "fullName": fullName,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "height": height,
        "weight": weight,
        "age": age,
        "tdee": tdee,
        "bmi": bmi,
        "bmr": bmr,
      };
}
