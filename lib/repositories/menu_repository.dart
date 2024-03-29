import 'dart:async';

import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class MenuReporitory {
  static final client = http.Client();

  static Future<String> getMenuByName() async {
    try {
      var response = await client.get(
        BuildServer.buildUrl('menu/menuName'),
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<String> getMenuByMenuId() async {
    try {
      var response = await client.get(
        BuildServer.buildUrl('menu/foodByMenuId'),
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
