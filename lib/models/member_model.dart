import 'dart:convert';

List<MemberModel> memberModelsFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
  int? memberID;
  String? email;
  String? accountPhoto;
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
    this.accountPhoto,
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
        accountPhoto: json["accountPhoto"],
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
        "accountPhoto": accountPhoto,
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

  @override
  String toString() {
    return 'MemberModel{memberID: $memberID, email: $email, accountPhoto: $accountPhoto, fullName: $fullName, gender: $gender, phoneNumber: $phoneNumber, height: $height, weight: $weight, age: $age, tdee: $tdee, bmi: $bmi, bmr: $bmr}';
  }
}
