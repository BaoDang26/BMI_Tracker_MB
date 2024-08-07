import 'dart:convert';

List<ExerciseModel> exerciseModelsFromJson(String str) =>
    List<ExerciseModel>.from(
        json.decode(str).map((x) => ExerciseModel.fromJson(x)));

List<ExerciseModel> exerciseModelsPagingFromJson(String str) =>
    List<ExerciseModel>.from(
        json.decode(str)["exercises"].map((x) => ExerciseModel.fromJson(x)));

String exerciseModelToJson(List<ExerciseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExerciseModel {
  int? exerciseID;
  String? exerciseName;
  String? emoji;
  int? duration;
  double? distance;
  bool? isActive;

  ExerciseModel({
    this.exerciseID,
    this.exerciseName,
    this.emoji,
    this.duration,
    this.distance,
    this.isActive,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      exerciseID: json['exerciseID'],
      exerciseName: json['exerciseName'],
      emoji: json['emoji'],
      duration: json['duration'],
      distance: json['distance'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseID': exerciseID,
      'exerciseName': exerciseName,
      'emoji': emoji,
      'duration': duration,
      'distance': distance,
      'isActive': isActive,
    };
  }

}
