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
