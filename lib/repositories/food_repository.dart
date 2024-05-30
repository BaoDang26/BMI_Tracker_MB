import 'dart:async';

import 'package:flutter_health_menu/constants/preUtils.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class FoodRepository {
  static final client = http.Client();

  static Future<dynamic> getAllFood() async {
    try {
      http.Response response = await client.get(
        headers: BuildServer.header,
        BuildServer.buildUrl('food'),
      );
      return response;
    } on TimeoutException catch (e) {
      e.toString();
    }
  }

  static Future<dynamic> getAllFoodInMenu() async {
    try {
      print('header: ${BuildServer.header}');
      http.Response response = await client.get(
        headers: BuildServer.header,
        BuildServer.buildUrl('member/getMenu'),
      );
      return response;
    } on TimeoutException catch (e) {
      e.toString();
    }
  }
}
