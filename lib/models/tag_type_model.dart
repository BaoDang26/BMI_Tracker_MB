import 'dart:convert';

import 'package:flutter_health_menu/models/tag_model.dart';

List<TagTypeModel> tagTypeModelsFromJson(String str) => List<TagTypeModel>.from(
    json.decode(str).map((x) => TagTypeModel.fromJson(x)));

String tagTypeModelsToJson(List<TagTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagTypeModel {
  int? tagTypeID;
  String? tagTypeName;
  List<TagModel>? tags;

  TagTypeModel({
    this.tagTypeID,
    this.tagTypeName,
    this.tags,
  });

  factory TagTypeModel.fromJson(Map<String, dynamic> json) {
    return TagTypeModel(
      tagTypeID: json['tagTypeID'],
      tagTypeName: json['tagTypeName'],
      tags: json['tags'] != null
          ? List<TagModel>.from(json['tags'].map((x) => TagModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tagTypeID': tagTypeID,
      'tagTypeName': tagTypeName,
      'tags': tags != null
          ? List<dynamic>.from(tags!.map((x) => x.toJson()))
          : null,
    };
  }

  @override
  String toString() {
    return 'TagTypeModel{tagTypeID: $tagTypeID, tagTypeName: $tagTypeName, tags: $tags}';
  }
}
