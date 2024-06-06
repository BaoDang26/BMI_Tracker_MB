import 'dart:async';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;

import '../util/preUtils.dart';

class OrderRepository {
  static final client = http.Client();

  static Future<http.Response> getPaymentUrl() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      };
      var response = await client
          .post(
            BuildServer.buildUrl(
                "test/transaction/payment?amount=51000&orderInfo=Test%20payment"),
            headers: header,
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException catch (e) {
      return http.Response("message: ${e.message}", 408);
    }
  }
}
