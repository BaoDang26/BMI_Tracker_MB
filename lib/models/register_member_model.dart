// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'dart:convert';

List<RegisterMemberModel> registerMemberModelFromJson(String str) =>
    List<RegisterMemberModel>.from(
        json.decode(str).map((x) => RegisterMemberModel.fromJson(x)));

String registerMemberModelToJson(List<RegisterMemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String registerMemberToJson(RegisterMemberModel data) {
  return json.encode(data.registerMemberToJson());
}

class RegisterMemberModel {
  // int? goalId;
  String? dietaryPreference;
  int? height;
  int? weight;
  int? targetWeight;
  int? activityLevelId;

  RegisterMemberModel({
    // this.goalId,
    this.dietaryPreference,
    this.height,
    this.weight,
    this.targetWeight,
    this.activityLevelId,
  });

  factory RegisterMemberModel.fromJson(Map<String, dynamic> json) =>
      RegisterMemberModel(
        // goalId: json["goalID"],
        dietaryPreference: json["dietaryPreference"],
        height: json["height"],
        weight: json["weight"],
        targetWeight: json["targetWeight"],
        activityLevelId: json["activityLevelID"],
      );

  Map<String, dynamic> toJson() => {
        // "goalID": goalId,
        "dietaryPreference": dietaryPreference,
        "height": height,
        "weight": weight,
        "targetWeight": targetWeight,
        "activityLevelID": activityLevelId,
      };

  Map<String, dynamic> registerMemberToJson() => {
        // "goalID": goalId,
        "dietaryPreference": dietaryPreference,
        "height": height,
        "weight": weight,
        "targetWeight": targetWeight,
        "activityLevelID": activityLevelId,
      };
}
