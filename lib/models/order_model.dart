import 'dart:convert';

List<OrderMode> orderModesFromJson(String str) =>
    List<OrderMode>.from(json.decode(str).map((x) => OrderMode.fromJson(x)));

String orderModeToJson(List<OrderMode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderMode {
  String? description;
  double? amount;
  int? advisorID;
  int? planDuration;

  OrderMode({
    this.description,
    this.amount,
    this.advisorID,
    this.planDuration,
  });

  factory OrderMode.fromJson(Map<String, dynamic> json) {
    return OrderMode(
      description: json['description'],
      amount: json['amount'],
      advisorID: json['advisorID'],
      planDuration: json['planDuration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'advisorID': advisorID,
      'planDuration': planDuration,
    };
  }
}
