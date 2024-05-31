import 'dart:convert';

List<AdvisorModel> memberModelFromJson(String str) => List<AdvisorModel>.from(
    json.decode(str).map((x) => AdvisorModel.fromJson(x)));

class AdvisorModel {
  final String? linkPhoto;
  final int? advisorID;
  final String? email;
  final String? fullName;
  final String? phoneNumber;
  final String? gender;
  final String? birthday;

  AdvisorModel({
     this.linkPhoto,
     this.advisorID,
     this.email,
     this.fullName,
     this.phoneNumber,
     this.gender,
     this.birthday,
  });

  factory AdvisorModel.fromJson(Map<String, dynamic> json) {
    return AdvisorModel(
      linkPhoto: json['linkPhoto'],
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
      'linkPhoto': linkPhoto,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'birthday': birthday,
    };
  }
}
