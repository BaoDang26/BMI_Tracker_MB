import 'dart:async';
import 'dart:convert';

import 'package:flutter_health_menu/models/combinded_order_request_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class OrderRepository { 
  static Future<http.Response> createOrderTransaction(CombinedOrderRequestModel requestModel) async {
    var response = await interceptedClient
        .post(BuildServer.buildUrl("orders/createTransaction"),
        headers: {
          "Content-type": "application/json",
        },
        body: json.encode(requestModel.toJson()))
        .timeout(const Duration(seconds: 30));
    return response;
  }
}
