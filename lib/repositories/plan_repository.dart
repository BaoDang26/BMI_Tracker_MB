import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class PlanRepository { 

  static Future<http.Response> getAllPlanByAdvisorID(int advisorID) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("plans/get-for-subscription/$advisorID"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
}
