import 'dart:convert';

List<NotificationModel> notificationModelsFromJson(String str) =>
    List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  int? notificationID;
  String? content;
  String? title;
  DateTime? createdTime;
  bool? isRead;

  NotificationModel({
    this.notificationID,
    this.content,
    this.title,
    this.createdTime,
    this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationID: json['notificationID'],
      content: json['content'],
      title: json['title'],
      createdTime: DateTime.parse(json['createdTime']),
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationID': notificationID,
      'content': content,
      'title': title,
      'createdTime': createdTime?.toIso8601String(),
      'isRead': isRead,
    };
  }
}
