import 'dart:convert';

import 'package:flutter_health_menu/util/date_time_utils.dart';

List<BookingModel> bookingModelsFromJson(String str) => List<BookingModel>.from(
    json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  int? bookingID;
  String? bookingNumber;
  String? bookingDescription;
  double? amount;
  DateTime? bookingDate;
  DateTime? startDate;
  DateTime? endDate;
  int? memberID;
  int? advisorID;
  String? bookingStatus;
  int? planID;

  BookingModel({
    this.bookingID,
    this.bookingNumber,
    this.bookingDescription,
    this.amount,
    this.bookingDate,
    this.startDate,
    this.endDate,
    this.memberID,
    this.advisorID,
    this.bookingStatus,
    this.planID,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingID: json['bookingID'],
      bookingNumber: json['bookingNumber'],
      bookingDescription: json['bookingDescription'],
      amount: (json['amount'] as num?)?.toDouble(),
      bookingDate: json['bookingDate'] != null
          ? DateTime.parse(json['bookingDate'])
          : null,
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      memberID: json['memberID'],
      advisorID: json['advisorID'],
      bookingStatus: json['bookingStatus'],
      planID: json['planID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingID': bookingID,
      'bookingNumber': bookingNumber,
      'bookingDescription': bookingDescription,
      'amount': amount,
      'bookingDate': bookingDate?.toIso8601String(),
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'memberID': memberID,
      'advisorID': advisorID,
      'bookingStatus': bookingStatus,
      'planID': planID,
    };
  }

  String getBookingDate() {
    return bookingDate!.format();
  }

  String getStartDate() {
    return startDate!.format();
  }

  String getEndDate() {
    return endDate!.format();
  }

  @override
  String toString() {
    return 'BookingModel{bookingID: $bookingID, bookingNumber: $bookingNumber, bookingDescription: $bookingDescription, amount: $amount, bookingDate: $bookingDate, startDate: $startDate, endDate: $endDate, memberID: $memberID, advisorID: $advisorID, bookingStatus: $bookingStatus, planID: $planID}';
  }
}
