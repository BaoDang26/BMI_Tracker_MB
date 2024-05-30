// To parse this JSON data, do
//
//     final activityLevelModel = activityLevelModelFromJson(jsonString);

import 'dart:convert';

List<ActivityLevelModel> activityLevelModelFromJson(String str) => List<ActivityLevelModel>.from(json.decode(str).map((x) => ActivityLevelModel.fromJson(x)));

String activityLevelModelToJson(List<ActivityLevelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityLevelModel {
    int? activityLevelId;
    String? activityLevelName;
    bool? active;
    double? activityLevel;

    ActivityLevelModel({
        this.activityLevelId,
        this.activityLevelName,
        this.active,
        this.activityLevel,
    });

    factory ActivityLevelModel.fromJson(Map<String, dynamic> json) => ActivityLevelModel(
        activityLevelId: json["activityLevelID"],
        activityLevelName: json["activityLevelName"],
        active: json["active"],
        activityLevel: json["activityLevel"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "activityLevelID": activityLevelId,
        "activityLevelName": activityLevelName,
        "active": active,
        "activityLevel": activityLevel,
    };
}
