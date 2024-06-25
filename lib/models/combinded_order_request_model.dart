// Main model to combine orderRequest and transactionRequest
class CombinedOrderRequestModel {
  BookingRequestModel orderRequest;
  TransactionRequestModel transactionRequest;

  CombinedOrderRequestModel({
    required this.orderRequest,
    required this.transactionRequest,
  });

  factory CombinedOrderRequestModel.fromJson(Map<String, dynamic> json) {
    return CombinedOrderRequestModel(
      orderRequest: BookingRequestModel.fromJson(json['orderRequest']),
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
class BookingRequestModel {
  String? description;
  double? amount;
  int? advisorID;
  int? planDuration;
  int? planID;
  String? orderNumber;

  BookingRequestModel({
    required this.description,
    required this.amount,
    required this.advisorID,
    required this.planDuration,
    required this.planID,
    required this.orderNumber,
  });

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) {
    return BookingRequestModel(
      description: json['description'],
      amount: json['amount'],
      advisorID: json['advisorID'],
      planDuration: json['planDuration'],
      planID: json['planID'],
      orderNumber: json['orderNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'advisorID': advisorID,
      'planDuration': planDuration,
      'planID': planID,
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
