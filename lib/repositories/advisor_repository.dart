import 'dart:async';

import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class AdvisorRepository {
  static final client = http.Client();

  static Future<http.Response> getListAdvisorWithDetails() async {
    Map<String, String> header = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
    };
    var response = await client
        .get(BuildServer.buildUrl('advisors/getWithDetails'), headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAdvisorByID(int advisorID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
    };
    var response = await client

        .get(BuildServer.buildUrl('advisors/getByID?advisorID=$advisorID'), headers: header)

        .timeout(const Duration(seconds: 30));
    return response;
  }
}
