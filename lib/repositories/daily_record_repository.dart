import 'package:flutter_health_menu/config/build_server.dart';
import 'package:http/http.dart' as http;

import '../util/preUtils.dart';

class DailyRecordRepository {
  static final client = http.Client();

  static Future<http.Response> fetchCaloriesOfMeal(String date) async {
    var response = await client.get(
      BuildServer.buildUrl("meallog/getCaloriesOfMeal?date=$date"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
  static Future<http.Response> fetchTotalCaloriesBurnedOfDate(String date) async {
    var response = await client.get(
      BuildServer.buildUrl("dailyrecords/getTotalCaloriesBurnedOfDate?date=$date"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAllActivityLogByDate(String date) async {
    var response = await client.get(
      BuildServer.buildUrl("activitylog/getAllByDate?date=$date"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

}
