import 'dart:convert';

import 'package:flutter_health_menu/util/date_time_utils.dart';

List<BookingModel> bookingModelsFromJson(String str) => List<BookingModel>.from(
    json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  int? subscriptionID;
  String? subscriptionNumber;
  String? subscriptionDescription;
  double? amount;
  DateTime? subscriptionDate;
  DateTime? startDate;
  DateTime? endDate;
  int? memberID;
  int? advisorID;
  String? subscriptionStatus;
  int? planID;

  BookingModel({
    this.subscriptionID,
    this.subscriptionNumber,
    this.subscriptionDescription,
    this.amount,
    this.subscriptionDate,
    this.startDate,
    this.endDate,
    this.memberID,
    this.advisorID,
    this.subscriptionStatus,
    this.planID,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
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
      advisorID: json['advisorID'],
      subscriptionStatus: json['subscriptionStatus'],
      planID: json['planID'],
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
      'advisorID': advisorID,
      'subscriptionStatus': subscriptionStatus,
      'planID': planID,
    };
  }

  String getsubscriptionDate() {
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
    return 'BookingModel{subscriptionID: $subscriptionID, subscriptionNumber: $subscriptionNumber, subscriptionDescription: $subscriptionDescription, amount: $amount, subscriptionDate: $subscriptionDate, startDate: $startDate, endDate: $endDate, memberID: $memberID, advisorID: $advisorID, subscriptionStatus: $subscriptionStatus, planID: $planID}';
  }
}
