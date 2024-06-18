import 'dart:convert';

List<AdvisorModel> advisorsModelFromJson(String str) => List<AdvisorModel>.from(
    json.decode(str).map((x) => AdvisorModel.fromJson(x)));

String advisorsModelToJson(List<AdvisorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvisorModel {
  String? accountPhoto;
  int? advisorID;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? gender;
  String? birthday;

  AdvisorModel({
    this.accountPhoto,
    this.advisorID,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.birthday,
  });

  factory AdvisorModel.fromJson(Map<String, dynamic> json) {
    return AdvisorModel(
      accountPhoto: json['accountPhoto'],
      // ?? "https://www.avatarfitness.co.uk/wp-content/uploads/Jacob-pdf.jpg",
      //json['linkPhoto'],
      advisorID: json['advisorID'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      birthday: json['birthday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountPhoto': accountPhoto,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'birthday': birthday,
    };
  }
}
