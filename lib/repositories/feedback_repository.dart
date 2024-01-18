import 'dart:async';

import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class FeedbackRepository {
  static final client = http.Client();

  static Future<String> registerFeedback(var body, String endpoint) async {
    try {
      var response = await client.post(
        BuildServer.buildUrl(endpoint),
        body: body,
        headers: {"Content-type": "application/json"},
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
