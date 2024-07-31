import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class StatisticsRepository {
  static Future<http.Response> getStatisticBodyMass(String date) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl(
          "statistics/member/member-bodymass/getInMonth?date=$date"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getStatisticCalories(String date) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl(
          "statistics/member/daily-record/week-by-date?date=$date"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
}
