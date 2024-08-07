class ExerciseTag {
  int? tagID;
  String? tagName;

  ExerciseTag({
    this.tagID,
    this.tagName,
  });

  factory ExerciseTag.fromJson(Map<String, dynamic> json) {
    return ExerciseTag(
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
    return 'ExerciseTag{tagID: $tagID, tagName: $tagName}';
  }
}
