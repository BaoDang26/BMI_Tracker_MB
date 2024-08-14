// Main model to combine subscriptionNumber and transactionRequest
class CombinedSubscriptionsRequestModel {
  BookingRequestModel subscriptionRequest;
  TransactionRequestModel transactionRequest;

  CombinedSubscriptionsRequestModel({
    required this.subscriptionRequest,
    required this.transactionRequest,
  });

  factory CombinedSubscriptionsRequestModel.fromJson(
      Map<String, dynamic> json) {
    return CombinedSubscriptionsRequestModel(
      subscriptionRequest:
          BookingRequestModel.fromJson(json['subscriptionRequest']),
      transactionRequest:
          TransactionRequestModel.fromJson(json['transactionRequest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscriptionRequest': subscriptionRequest.toJson(),
      'transactionRequest': transactionRequest.toJson(),
    };
  }
}

// Model for orderRequest
class BookingRequestModel {
  String? description;
  double? amount;
  int? advisorID;
  int? packageDuration;
  int? packageID;
  String? subscriptionNumber;

  BookingRequestModel({
    required this.description,
    required this.amount,
    required this.advisorID,
    required this.packageDuration,
    required this.packageID,
    required this.subscriptionNumber,
  });

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) {
    return BookingRequestModel(
      description: json['description'],
      amount: json['amount'],
      advisorID: json['advisorID'],
      packageDuration: json['packageDuration'],
      packageID: json['packageID'],
      subscriptionNumber: json['subscriptionNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'advisorID': advisorID,
      'packageDuration': packageDuration,
      'packageID': packageID,
      'subscriptionNumber': subscriptionNumber,
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
