import 'dart:convert';

List<TagModel> tagModelsFromJson(String str) => List<TagModel>.from(
    json.decode(str).map((x) => TagModel.fromJson(x)));

String tagModelsToJson(List<TagModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagModel {
  int? tagID;
  String? tagName;
  String? tagDescription;
  bool isChecked;

  TagModel({
    this.tagID,
    this.tagName,
    this.tagDescription,
    this.isChecked = false,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      tagID: json['tagID'],
      tagName: json['tagName'],
      // tagDescription: json['tagDescription'],
      tagDescription: json['tagDescription'] ?? '',
      isChecked: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tagID': tagID,
      'tagName': tagName,
      // 'tagDescription': tagDescription,
      'tagDescription': tagDescription,
    };
  }

  @override
  String toString() {
    return 'TagModel{tagID: $tagID, tagName: $tagName, tagDescription: $tagDescription}';
  }
}
