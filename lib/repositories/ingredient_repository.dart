import 'dart:async';

import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class IngredientRepository { 
  static Future<String> getAllIngredient() async {
    try {
      var response = await interceptedClient.get(
        BuildServer.buildUrl('ingredient'),
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<String> getIngredientByFoodId(String endpoint) async {
    try {
      var response = await interceptedClient.get(
        BuildServer.buildUrl(endpoint),
        headers: {"Content-type": "application/json"},
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
