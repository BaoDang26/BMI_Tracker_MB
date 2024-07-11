import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class TagTypeRepository {
  static Future<http.Response> getAllTagFood() async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl(" "),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
}
