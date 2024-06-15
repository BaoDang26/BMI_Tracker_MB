class FoodTag {
  int? tagID;
  String? tagName;

  FoodTag({
    this.tagID,
    this.tagName,
  });

  factory FoodTag.fromJson(Map<String, dynamic> json) {
    return FoodTag(
      tagID: json['tagID'],
      tagName: json['tagName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tagID': tagID,
      'tagName': tagName,
    };
  }

  @override
  String toString() {
    return 'FoodTag{tagID: $tagID, tagName: $tagName}';
  }
}
