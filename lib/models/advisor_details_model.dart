import 'dart:convert';

List<AdvisorDetailsModel> advisorModelsFromJson(String str) => List<AdvisorDetailsModel>.from(
    json.decode(str).map((x) => AdvisorDetailsModel.fromJson(x)));

String advisorModelToJson(List<AdvisorDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvisorDetailsModel {
  int? advisorID;
  String? accountPhoto;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? gender;
  DateTime? birthday;
  int? totalBooking;
  int? totalMenuCreated;
  int? totalWorkoutCreated;

  AdvisorDetailsModel({
    this.advisorID,
    this.accountPhoto,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.birthday,
    this.totalBooking,
    this.totalMenuCreated,
    this.totalWorkoutCreated,
  });

  factory AdvisorDetailsModel.fromJson(Map<String, dynamic> json) {
    return AdvisorDetailsModel(
      advisorID: json['advisorID'],
      accountPhoto: json['accountPhoto'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      totalBooking: json['totalBooking'],
      totalMenuCreated: json['totalMenuCreated'],
      totalWorkoutCreated: json['totalWorkoutCreated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'advisorID': advisorID,
      'accountPhoto': accountPhoto,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'birthday': birthday?.toIso8601String(),
      'totalBooking': totalBooking,
      'totalMenuCreated': totalMenuCreated,
      'totalWorkoutCreated': totalWorkoutCreated,
    };
  }
}
