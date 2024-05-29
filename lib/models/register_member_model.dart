// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'dart:convert';

List<RegisterMemberModel> registerMemberModelFromJson(String str) => List<RegisterMemberModel>.from(json.decode(str).map((x) => RegisterMemberModel.fromJson(x)));

String registerMemberModelToJson(List<RegisterMemberModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String registerMemberToJson(RegisterMemberModel data) {
  return json.encode(data.registerMemberToJson());
}

class RegisterMemberModel {
    int? goalId;
    int? dietaryPreferenceId;
    int? height;
    int? weight;
    int? targetWeight;
    int? activityLevelId;

    RegisterMemberModel({
        this.goalId,
        this.dietaryPreferenceId,
        this.height,
        this.weight,
        this.targetWeight,
        this.activityLevelId,
    });

    factory RegisterMemberModel.fromJson(Map<String, dynamic> json) => RegisterMemberModel(
        goalId: json["goalID"],
        dietaryPreferenceId: json["dietaryPreferenceID"],
        height: json["height"],
        weight: json["weight"],
        targetWeight: json["targetWeight"],
        activityLevelId: json["activityLevelID"],
    );

    Map<String, dynamic> toJson() => {
        "goalID": goalId,
        "dietaryPreferenceID": dietaryPreferenceId,
        "height": height,
        "weight": weight,
        "targetWeight": targetWeight,
        "activityLevelID": activityLevelId,
    };

    Map<String, dynamic> registerMemberToJson() => {
        "goalID": goalId,
        "dietaryPreferenceID": dietaryPreferenceId,
        "height": height,
        "weight": weight,
        "targetWeight": targetWeight,
        "activityLevelID": activityLevelId,
    };
}
