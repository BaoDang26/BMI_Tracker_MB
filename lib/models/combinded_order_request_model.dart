import 'dart:convert';

// Main model to combine orderRequest and transactionRequest
class CombinedOrderRequestModel {
  OrderRequestModel orderRequest;
  TransactionRequestModel transactionRequest;

  CombinedOrderRequestModel({
    required this.orderRequest,
    required this.transactionRequest,
  });

  factory CombinedOrderRequestModel.fromJson(Map<String, dynamic> json) {
    return CombinedOrderRequestModel(
      orderRequest: OrderRequestModel.fromJson(json['orderRequest']),
      transactionRequest:
          TransactionRequestModel.fromJson(json['transactionRequest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderRequest': orderRequest.toJson(),
      'transactionRequest': transactionRequest.toJson(),
    };
  }
}

// Model for orderRequest
class OrderRequestModel {
  String description;
  double amount;
  int advisorID;
  int planDuration;
  String orderNumber;

  OrderRequestModel({
    required this.description,
    required this.amount,
    required this.advisorID,
    required this.planDuration,
    required this.orderNumber,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      description: json['description'],
      amount: json['amount'],
      advisorID: json['advisorID'],
      planDuration: json['planDuration'],
      orderNumber: json['orderNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'advisorID': advisorID,
      'planDuration': planDuration,
      'orderNumber': orderNumber,
    };
  }
}

// Model for transactionRequest
class TransactionRequestModel {
  String zpTransToken;
  String payDate;
  String transactionMessage;
  String transactionSubMessage;
  double amount;
  String orderToken;

  TransactionRequestModel({
    required this.zpTransToken,
    required this.payDate,
    required this.transactionMessage,
    required this.transactionSubMessage,
    required this.amount,
    required this.orderToken,
  });

  factory TransactionRequestModel.fromJson(Map<String, dynamic> json) {
    return TransactionRequestModel(
      zpTransToken: json['zpTransToken'],
      payDate: json['payDate'],
      transactionMessage: json['transactionMessage'],
      transactionSubMessage: json['transactionSubMessage'],
      amount: json['amount'],
      orderToken: json['orderToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zpTransToken': zpTransToken,
      'payDate': payDate,
      'transactionMessage': transactionMessage,
      'transactionSubMessage': transactionSubMessage,
      'amount': amount,
      'orderToken': orderToken,
    };
  }
}
