import 'dart:convert';

List<ActivityLogRequest> activityLogRequestsFromJson(String str) =>
    List<ActivityLogRequest>.from(
        json.decode(str).map((x) => ActivityLogRequest.fromJson(x)));

String activityLogRequestToJson(List<ActivityLogRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityLogRequest {
  String? activityName;
  String? emoji;

  // int? caloriesBurned;
  double? distance;
  int? duration;
  String? dateOfActivity;
  int? exerciseID;

  ActivityLogRequest({
    this.dateOfActivity,
    this.activityName,
    this.emoji,
    this.distance,
    this.duration,
    this.exerciseID,
  });

  factory ActivityLogRequest.fromJson(Map<String, dynamic> json) {
    return ActivityLogRequest(
      dateOfActivity: json['dateOfActivity'],
      activityName: json['activityName'],
      emoji: json['emoji'],
      distance: json['distance'],
      duration: json['duration'],
      exerciseID: json['exerciseID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateOfActivity': dateOfActivity,
      'activityName': activityName,
      'emoji': emoji,
      'distance': distance,
      'duration': duration,
      'exerciseID': exerciseID,
    };
  }
}
