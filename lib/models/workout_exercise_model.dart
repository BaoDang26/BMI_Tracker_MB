import 'dart:convert';

import '../util/tag_emoji_utils.dart';

List<WorkoutExerciseModel> workoutExerciseModelsFromJson(String str) =>
    List<WorkoutExerciseModel>.from(
        json.decode(str).map((x) => WorkoutExerciseModel.fromJson(x)));

String workoutExerciseModelsToJson(List<WorkoutExerciseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkoutExerciseModel {
  int? workoutExerciseID;
  int? exerciseID;
  String? exerciseName;
  String? exercisePhoto;
  String? exerciseVideo;
  double? met;
  String? exerciseDescription;
  int? tagID;
  String? tagName;
  int? duration; // Duration in minutes
  int? caloriesBurned;
  String? emoji;
  bool? isActive;

  WorkoutExerciseModel({
    this.workoutExerciseID,
    this.exerciseID,
    this.exerciseName,
    this.exercisePhoto,
    this.exerciseVideo,
    this.met,
    this.exerciseDescription,
    this.tagID,
    this.tagName,
    this.duration,
    this.caloriesBurned,
    this.emoji,
    this.isActive,
  });

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) {
    int? tagID = json['tagID'];
    String emoji = TagEmojiUtils.getEmojiForTag(tagID);
    return WorkoutExerciseModel(
        workoutExerciseID: json['workoutExerciseID'],
        exerciseID: json['exerciseID'],
        exerciseName: json['exerciseName'],
        exercisePhoto: json['exercisePhoto'],
        exerciseVideo: json['exerciseVideo'],
        met: json['met'],
        exerciseDescription: json['exerciseDescription'],
        tagID: json['tagID'],
        tagName: json['tagName'],
        duration: json['duration'],
        caloriesBurned: json['caloriesBurned'],
        isActive: json['isActive'],
        emoji: emoji);
  }

  Map<String, dynamic> toJson() {
    return {
      'workoutExerciseID': workoutExerciseID,
      'exerciseID': exerciseID,
      'exerciseName': exerciseName,
      'exercisePhoto': exercisePhoto,
      'exerciseVideo': exerciseVideo,
      'met': met,
      'exerciseDescription': exerciseDescription,
      'tagID': tagID,
      'tagName': tagName,
      'duration': duration,
      'caloriesBurned': caloriesBurned,
      'isActive': isActive,
    };
  }
}
