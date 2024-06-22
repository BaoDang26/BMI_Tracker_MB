import 'dart:async';
import 'dart:convert';

import 'package:flutter_health_menu/models/combinded_order_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class BookingRepository {
  static Future<http.Response> createOrderTransaction(
      CombinedOrderRequestModel requestModel) async {
    var response = await interceptedClient
        .post(BuildServer.buildUrl("bookings/createTransaction"),
            headers: {
              "Content-type": "application/json",
            },
            body: json.encode(requestModel.toJson()))
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAllBookingByMember() async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("bookings/getByMember"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
}
