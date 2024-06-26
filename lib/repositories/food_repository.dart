import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class FoodRepository {
  static Future<dynamic> getAllFood() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
      };

      http.Response response = await interceptedClient.get(
        headers: header,
        BuildServer.buildUrl('food'),
      );
      return response;
    } on TimeoutException catch (e) {
      e.toString();
    }
  }

  static Future<http.Response> getAllFoodInMenu() async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };

    http.Response response = await interceptedClient.get(
      headers: header,
      BuildServer.buildUrl('member/getMenu'),
    );
    return response;
  }

  static Future<http.Response> getFoodByID(int foodID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };

    http.Response response = await interceptedClient.get(
      headers: header,
      BuildServer.buildUrl('foods/getByID/$foodID'),
    );
    return response;
  }
}
