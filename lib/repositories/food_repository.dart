import 'dart:async';

import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class FoodRepository {
  static final client = http.Client();

  static Future<dynamic> getAllFood() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      };

      http.Response response = await client.get(
        headers: header,
        BuildServer.buildUrl('food'),
      );
      return response;
    } on TimeoutException catch (e) {
      e.toString();
    }
  }

  static Future<dynamic> getAllFoodInMenu() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      };

      http.Response response = await client.get(
        headers: header,
        BuildServer.buildUrl('member/getMenu'),
      );
      return response;
    } on TimeoutException catch (e) {
      e.toString();
    }
  }

  static Future<http.Response> getFoodByID(int foodID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
    };

    http.Response response = await client.get(
      headers: header,
      BuildServer.buildUrl('foods/getByID/$foodID'),
    );
    return response;
  }
}
