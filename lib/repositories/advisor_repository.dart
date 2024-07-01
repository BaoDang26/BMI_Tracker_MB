import 'dart:async';

import 'package:flutter_health_menu/repository/jwt_interceptor.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class AdvisorRepository {
  static Future<http.Response> getListAdvisorWithDetails() async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .get(BuildServer.buildUrl('advisors/getWithDetails'), headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAdvisorByID(int advisorID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .get(BuildServer.buildUrl('advisors/getByID?advisorID=$advisorID'),
            headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }
}
