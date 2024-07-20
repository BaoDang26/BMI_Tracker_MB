import 'dart:convert';

import 'package:flutter_health_menu/util/tag_emoji_utils.dart';

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
  String? exercisePhoto;
  String? exerciseVideo;
  double? met;
  String? exerciseDescription;
  String? emoji;
  int? tagID;
  String? tagName;
  bool? isActive;

  ExerciseModel({
    this.exerciseID,
    this.exerciseName,
    this.exercisePhoto,
    this.exerciseVideo,
    this.met,
    this.exerciseDescription,
    this.tagID,
    this.tagName,
    this.emoji,
    this.isActive,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    int? tagID = json['tagID'];
    String? emoji = TagEmojiUtils.getEmojiForTag(tagID);

    return ExerciseModel(
      exerciseID: json['exerciseID'],
      exerciseName: json['exerciseName'],
      exercisePhoto: json['exercisePhoto'],
      exerciseVideo: json['exerciseVideo'],
      met: json['met'],
      exerciseDescription: json['exerciseDescription'],
      tagID: json['tagID'],
      tagName: json['tagName'],
      emoji: emoji,
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseID': exerciseID,
      'exerciseName': exerciseName,
      'exercisePhoto': exercisePhoto,
      'exerciseVideo': exerciseVideo,
      'met': met,
      'exerciseDescription': exerciseDescription,
      'tagID': tagID,
      'tagName': tagName,
      'isActive': isActive,
    };
  }
}
