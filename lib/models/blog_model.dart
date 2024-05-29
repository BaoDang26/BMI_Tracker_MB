// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/models/models.dart';

// BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

// String blogModelToJson(BlogModel data) => json.encode(data.toJson());

List<BlogModel> blogModelFromJson(String str) =>
    List<BlogModel>.from(json.decode(str).map((x) => BlogModel.fromJson(x)));

String blogModelToJson(List<BlogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogModel {
  String? bolgId;
  String? blogName;
  String? blogContent;
  String? blogPhoto;
  String? link;
  String? tag;
  DateTime? dateTime;
  String? status;
  String? userId;
  MemberModel? members;

  BlogModel({
    this.bolgId,
    this.blogName,
    this.blogContent,
    this.blogPhoto,
    this.link,
    this.tag,
    this.dateTime,
    this.status,
    this.userId,
    this.members,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        bolgId: json["bolgId"],
        blogName: json["blogName"],
        blogContent: json["blogContent"],
        blogPhoto: json["blogPhoto"],
        link: json["link"],
        tag: json["tag"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        status: json["status"],
        userId: json["userId"],
        members: json["members"] == null ? null : MemberModel.fromJson(json["members"]),
      );

  Map<String, dynamic> toJson() => {
        "bolgId": bolgId,
        "blogName": blogName,
        "blogContent": blogContent,
        "blogPhoto": blogPhoto,
        "link": link,
        "tag": tag,
        "dateTime": dateTime?.toIso8601String(),
        "status": status,
        "userId": userId,
        "members": members?.toJson(),
      };
}
