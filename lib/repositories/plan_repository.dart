import 'dart:async';

import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class PlanRepository {
  static final client = http.Client();

  static Future<http.Response> getAllPlanByAdvisorID(int advisorID) async {
    var response = await client.get(
      BuildServer.buildUrl("plans/getByAdvisorID/$advisorID"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
}
