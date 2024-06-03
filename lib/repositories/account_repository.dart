import 'dart:async';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;

import '../util/preUtils.dart';

class AccountRepository {
  static final client = http.Client();

  static Future<String> logout() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      };
      var response = await client.get(
        BuildServer.buildUrl("auth/logout"),
        headers: header,
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
