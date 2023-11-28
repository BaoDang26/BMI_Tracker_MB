import 'dart:async';

import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class FoodRepository {
  static final client = http.Client();

  static Future<String> getAllFood() async {
    try {
      var response = await client.get(
        BuildServer.buildUrl('food'),
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
