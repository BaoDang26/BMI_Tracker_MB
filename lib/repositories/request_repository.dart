import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/build_server.dart';
import '../models/request_model.dart';
import '../repository/jwt_interceptor.dart';

class RequestRepository {
  static Future<http.Response> fetchRequest() async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("user-requests/get-all-for-user"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> createNewRequest(
      RequestModel createRequest) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient.post(
        BuildServer.buildUrl("user-requests/create-new"),
        headers: header,
        body: json.encode(createRequest.toJson()));
    return response;
  }
}
