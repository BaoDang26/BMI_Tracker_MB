// Main model to combine bookingNumber and transactionRequest
class CombinedBookingRequestModel {
  BookingRequestModel bookingRequest;
  TransactionRequestModel transactionRequest;

  CombinedBookingRequestModel({
    required this.bookingRequest,
    required this.transactionRequest,
  });

  factory CombinedBookingRequestModel.fromJson(Map<String, dynamic> json) {
    return CombinedBookingRequestModel(
      bookingRequest: BookingRequestModel.fromJson(json['bookingRequest']),
      transactionRequest:
          TransactionRequestModel.fromJson(json['transactionRequest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingRequest': bookingRequest.toJson(),
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
  String? bookingNumber;

  BookingRequestModel({
    required this.description,
    required this.amount,
    required this.advisorID,
    required this.planDuration,
    required this.planID,
    required this.bookingNumber,
  });

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) {
    return BookingRequestModel(
      description: json['description'],
      amount: json['amount'],
      advisorID: json['advisorID'],
      planDuration: json['planDuration'],
      planID: json['planID'],
      bookingNumber: json['bookingNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'advisorID': advisorID,
      'planDuration': planDuration,
      'planID': planID,
      'bookingNumber': bookingNumber,
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
