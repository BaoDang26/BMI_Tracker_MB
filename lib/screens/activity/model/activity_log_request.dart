import 'dart:convert';

List<ActivityLogRequest> activityLogRequestsFromJson(String str) =>
    List<ActivityLogRequest>.from(
        json.decode(str).map((x) => ActivityLogRequest.fromJson(x)));

String activityLogRequestToJson(List<ActivityLogRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityLogRequest {
  String? activityName;
  String? emoji;
  int? caloriesBurned;
  int? duration;
  String? dateOfActivity;
  int? exerciseID;

  ActivityLogRequest({
    this.dateOfActivity,
    this.activityName,
    this.emoji,
    this.caloriesBurned,
    this.duration,
    this.exerciseID,
  });

  factory ActivityLogRequest.fromJson(Map<String, dynamic> json) {
    return ActivityLogRequest(
      dateOfActivity: json['dateOfActivity'],
      activityName: json['activityName'],
      emoji: json['emoji'],
      caloriesBurned: json['caloriesBurned'],
      duration: json['duration'],
      exerciseID: json['exerciseID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateOfActivity': dateOfActivity,
      'activityName': activityName,
      'emoji': emoji,
      'caloriesBurned': caloriesBurned,
      'duration': duration,
      'exerciseID': exerciseID,
    };
  }
}
