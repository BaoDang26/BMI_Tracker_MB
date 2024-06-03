import 'dart:async';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;

class BlogRepository {
  static final client = http.Client();

  static Future<String> getBlogByMemberId(String endpoint) async {
    try {
      var response = await client.get(
        BuildServer.buildUrl(endpoint),
        headers: {"Content-type": "application/json"},
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
