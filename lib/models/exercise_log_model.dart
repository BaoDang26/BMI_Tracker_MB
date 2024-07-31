import 'dart:convert';

List<ActivityLogModel> exerciseLogModelsFromJson(String str) =>
    List<ActivityLogModel>.from(
        json.decode(str).map((x) => ActivityLogModel.fromJson(x)));

String exerciseLogModelToJson(List<ActivityLogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityLogModel {
  int? activityLogID;
  String? activityName;
  String? emoji;
  int? caloriesBurned;
  int? duration;
  int? recordID;
  int? exerciseID;

  ActivityLogModel({
    this.activityLogID,
    this.activityName,
    this.emoji,
    this.caloriesBurned,
    this.duration,
    this.recordID,
    this.exerciseID,
  });

  factory ActivityLogModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogModel(
      activityLogID: json['activityLogID'],
      activityName: json['activityName'],
      emoji: json['emoji'],
      caloriesBurned: json['caloriesBurned'],
      duration: json['duration'],
      recordID: json['recordID'],
      exerciseID: json['exerciseID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityLogID': activityLogID,
      'activityName': activityName,
      'emoji': emoji,
      'caloriesBurned': caloriesBurned,
      'duration': duration,
      'recordID': recordID,
      'exerciseID': exerciseID,
    };
  }
}
