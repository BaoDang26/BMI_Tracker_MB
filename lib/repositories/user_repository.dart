import 'dart:async';

import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class UserRepository {
  static final client = http.Client();

  static Future<String> postLogin(var body) async {
    try {
      var response = await client.post(
        BuildServer.buildUrl('user/login'),
        body: body,
        headers: {"Content-type": "application/json"},
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
