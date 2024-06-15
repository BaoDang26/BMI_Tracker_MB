class CreatePaymentResponse {
  final String? zptranstoken;
  final String? orderurl;
  final int? returncode;
  final String? returnmessage;
  final int? subreturncode;
  final String? subreturnmessage;
  final String? ordertoken;

  CreatePaymentResponse(
      {this.zptranstoken,
      this.orderurl,
      this.returncode,
      this.returnmessage,
      this.subreturncode,
      this.subreturnmessage,
      this.ordertoken});

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) {
    return CreatePaymentResponse(
      zptranstoken: json['zp_trans_token'] as String,
      orderurl: json['order_url'] as String,
      returncode: json['return_code'] as int,
      returnmessage: json['return_message'] as String,
      subreturncode: json['sub_return_code'] as int,
      subreturnmessage: json['sub_return_message'] as String,
      ordertoken: json["order_token"] as String,
    );
  }
}
