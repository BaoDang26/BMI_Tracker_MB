import 'dart:async';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;

class AccountRepository {
  static final client = http.Client();

  static Future<String> logout() async {
    try {
      var response = await client.get(
        BuildServer.buildUrl("auth/logout"),
        headers: BuildServer.header,
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
