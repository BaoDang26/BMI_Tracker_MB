import 'dart:convert';

import 'package:flutter_health_menu/config/build_server.dart';
import 'package:flutter_health_menu/models/meal_log_model.dart';
import 'package:flutter_health_menu/screens/home/model/meal_log_request.dart';
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

  static Future<http.Response> fetchTotalCaloriesBurnedOfDate(
      String date) async {
    var response = await client.get(
      BuildServer.buildUrl(
          "dailyrecords/getTotalCaloriesBurnedOfDate?date=$date"),
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

  static Future<http.Response> getAllMelLogOfDateByMealType(
      String date, String mealType) async {
    var response = await client.get(
      BuildServer.buildUrl(
          "meallog/getAllMelLogOfDateByMealType?date=$date&mealType=$mealType"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> createMealLog(
      MealLogRequest mealLogRequest) async {
    var response = await client
        .post(BuildServer.buildUrl("meallog/createNew"),
            headers: {
              "Content-type": "application/json",
              'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
            },
            body: json.encode(mealLogRequest.toJson()))
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getMenuByMealType(String mealType) async {
    var response = await client.post(
      BuildServer.buildUrl("meallog/getMenuByMealType?mealType=$mealType"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
}
