import 'dart:async';

import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class MenuRepository { 
  static Future<String> getMenuByName() async {
    try {
      var response = await interceptedClient.get(
        BuildServer.buildUrl('menu/menuName'),
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<String> getMenuByMenuId() async {
    try {
      var response = await interceptedClient.get(
        BuildServer.buildUrl('menu/foodByMenuId'),
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
}
