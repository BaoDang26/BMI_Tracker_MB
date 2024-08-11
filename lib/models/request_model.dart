// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/util/app_export.dart';

List<RequestModel> requestModelFromJson(String str) => List<RequestModel>.from(
    json.decode(str).map((x) => RequestModel.fromJson(x)));

String requestModelToJson(List<RequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestModel {
  int? userRequestId;
  String? type;
  String? purpose;
  String? processNote;
  String? status;
  DateTime? creationDate;
  dynamic? processingDate;
  String? fullName;

  RequestModel({
    this.userRequestId,
    this.type,
    this.purpose,
    this.processNote,
    this.status,
    this.creationDate,
    this.processingDate,
    this.fullName,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        userRequestId: json["userRequestID"],
        type: json["type"],
        purpose: json["purpose"],
        processNote: json["processNote"] != null ? json["processNote"] : '',
        status: json["status"],
        creationDate: DateTime.parse(json["creationDate"]),
        processingDate: json["processingDate"] != null
            ? DateTime.parse(json["processingDate"])
            : '',
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "userRequestID": userRequestId,
        "type": type,
        "purpose": purpose,
        "processNote": processNote,
        "status": status,
        "creationDate":
            "${creationDate?.year.toString().padLeft(4, '0')}-${creationDate?.month.toString().padLeft(2, '0')}-${creationDate?.day.toString().padLeft(2, '0')}",
        "processingDate":
            "${processingDate?.year.toString().padLeft(4, '0')}-${processingDate?.month.toString().padLeft(2, '0')}-${processingDate?.day.toString().padLeft(2, '0')}",
        "fullName": fullName,
      };

  String getCreationDate() {
    return creationDate!.format();
  }
}

extension RequestModelExtension on RequestModel {
  String getProcessingDate() {
    if (processingDate == "") {
      return processingDate;
    } else {
      DateTime date = DateTime.parse(processingDate.toString());
      return date.format(); // Example format
    }
  }
}
