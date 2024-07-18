import 'dart:convert';

import 'package:flutter_health_menu/util/date_time_utils.dart';

List<SubscriptionModel> subscriptionModelsFromJson(String str) =>
    List<SubscriptionModel>.from(
        json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

String bookingModelToJson(List<SubscriptionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionModel {
  int? subscriptionID;
  String? subscriptionNumber;
  String? subscriptionDescription;
  double? amount;
  DateTime? subscriptionDate;
  DateTime? startDate;
  DateTime? endDate;
  int? memberID;
  String? memberName;
  int? advisorID;
  String? advisorName;
  String? subscriptionStatus;

  SubscriptionModel({
    this.subscriptionID,
    this.subscriptionNumber,
    this.subscriptionDescription,
    this.amount,
    this.subscriptionDate,
    this.startDate,
    this.endDate,
    this.memberID,
    this.memberName,
    this.advisorID,
    this.advisorName,
    this.subscriptionStatus,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      subscriptionID: json['subscriptionID'],
      subscriptionNumber: json['subscriptionNumber'],
      subscriptionDescription: json['subscriptionDescription'],
      amount: (json['amount'] as num?)?.toDouble(),
      subscriptionDate: json['subscriptionDate'] != null
          ? DateTime.parse(json['subscriptionDate'])
          : null,
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      memberID: json['memberID'],
      memberName: json['memberName'],
      advisorID: json['advisorID'],
      advisorName: json['advisorName'],
      subscriptionStatus: json['subscriptionStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscriptionID': subscriptionID,
      'subscriptionNumber': subscriptionNumber,
      'subscriptionDescription': subscriptionDescription,
      'amount': amount,
      'subscriptionDate': subscriptionDate?.toIso8601String(),
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'memberID': memberID,
      'memberName': memberName,
      'advisorID': advisorID,
      'advisorName': advisorName,
      'subscriptionStatus': subscriptionStatus,
    };
  }

  String getSubscriptionDate() {
    return subscriptionDate!.format();
  }

  String getStartDate() {
    return startDate!.format();
  }

  String getEndDate() {
    return endDate!.format();
  }

  @override
  String toString() {
    return 'SubscriptionModel{subscriptionID: $subscriptionID, subscriptionNumber: $subscriptionNumber, subscriptionDescription: $subscriptionDescription, amount: $amount, subscriptionDate: $subscriptionDate, startDate: $startDate, endDate: $endDate, memberID: $memberID, memberName: $memberName, advisorID: $advisorID, advisorName: $advisorName, subscriptionStatus: $subscriptionStatus}';
  }
}
