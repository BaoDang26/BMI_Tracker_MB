import 'dart:convert';

List<TagCheckBoxModel> tagModelsFromJson(String str) =>
    List<TagCheckBoxModel>.from(json.decode(str).map((x) => TagCheckBoxModel.fromJson(x)));

String tagModelsToJson(List<TagCheckBoxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagCheckBoxModel {
  int? tagID;
  String? tagName;
  String? tagDescription;
  bool checked = false;

  TagCheckBoxModel({
    this.tagID,
    this.tagName,
    this.tagDescription,
  });

  factory TagCheckBoxModel.fromJson(Map<String, dynamic> json) {
    return TagCheckBoxModel(
      tagID: json['tagID'],
      tagName: json['tagName'],
      tagDescription: json['tagDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tagID': tagID,
      'tagName': tagName,
      'tagDescription': tagDescription,
    };
  }
}
