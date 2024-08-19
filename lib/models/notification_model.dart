import 'dart:convert';

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

  static List<NotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<NotificationModel> notifications) {
    return notifications.map((notification) => notification.toJson()).toList();
  }
}

List<NotificationModel> notificationsFromJson(String str) {
  final jsonData = json.decode(str);
  return NotificationModel.fromJsonList(jsonData);
}

String notificationToJson(List<NotificationModel> data) {
  final jsonData = NotificationModel.toJsonList(data);
  return json.encode(jsonData);
}
