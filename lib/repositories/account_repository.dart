import 'dart:async';
import 'dart:convert';

import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;

class AccountRepository {
  static Future<String> logout() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
      };
      var response = await interceptedClient
          .post(
            BuildServer.buildUrl("auth/logout"),
            headers: header,
          )
          .timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<http.Response> updateProfile(var body) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .put(
          BuildServer.buildUrl("accounts/update-profile"),
          headers: header,
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> updateAccountPhoto(String photoUrl) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .put(
          BuildServer.buildUrl("accounts/update-avatar?imageLink=$photoUrl"),
          headers: header,
        )
        .timeout(const Duration(seconds: 30));
    return response;
  }
}
