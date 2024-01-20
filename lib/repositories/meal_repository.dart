import 'dart:async';

import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class MealRepository {
  static final client = http.Client();

  static Future<String> getMealByMenuId(String endpoint) async {
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

  static Future<String> getMealByFoodId(String endpoint) async {
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
