import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class MealRepository {
  static Future<String> getMealByMenuId(String endpoint) async {
    try {
      var response = await interceptedClient.get(
        BuildServer.buildUrl(endpoint),
        headers: {
          "Content-type": "application/json",
        },
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<String> getMealByFoodId(String endpoint) async {
    try {
      var response = await interceptedClient.get(
        BuildServer.buildUrl(endpoint),
        headers: {
          "Content-type": "application/json",
        },
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
