import 'dart:async';
import 'dart:convert';

import 'package:flutter_health_menu/models/combinded_order_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class SubscriptionsRepository {
  static Future<http.Response> createSubscriptionsTransaction(
      CombinedSubscriptionsRequestModel requestModel) async {
    var response = await interceptedClient
        .post(BuildServer.buildUrl("subscriptions/createTransaction"),
            headers: {
              "Content-type": "application/json",
            },
            body: json.encode(requestModel.toJson()))
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAllSubscriptionByMember() async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("subscriptions/getByMember"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAdvisorOfMember() async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .get(BuildServer.buildUrl('subscriptions/advisor/getByMember'),
            headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }
}
