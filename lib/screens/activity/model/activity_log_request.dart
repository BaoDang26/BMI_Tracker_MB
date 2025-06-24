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
  int? duration; // Duration in hours
  String? dateOfActivity;
  int? exerciseID;

  ActivityLogRequest({
    this.activityName,
    this.emoji,
    this.caloriesBurned,
    this.duration,
    this.dateOfActivity,
    this.exerciseID,
  });

  factory ActivityLogRequest.fromJson(Map<String, dynamic> json) {
    return ActivityLogRequest(
      activityName: json['activityName'],
      emoji: json['emoji'],
      caloriesBurned: json['caloriesBurned'],
      duration: json['duration'],
      dateOfActivity: json['dateOfActivity'],
      exerciseID: json['exerciseID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityName': activityName,
      'emoji': emoji,
      'caloriesBurned': caloriesBurned,
      'duration': duration,
      'dateOfActivity': dateOfActivity,
      'exerciseID': exerciseID,
    };
  }
}
