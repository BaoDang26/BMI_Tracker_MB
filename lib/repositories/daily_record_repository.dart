import 'dart:convert';

import 'package:flutter_health_menu/config/build_server.dart';
import 'package:flutter_health_menu/models/meal_log_model.dart';
import 'package:http/http.dart' as http;

import '../screens/meal/model/meal_log_request.dart';
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
    var response = await client.get(
      BuildServer.buildUrl("member/getMenuByMealType?mealType=$mealType"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getDailyRecordInWeek(String date) async {
    var response = await client.get(
      BuildServer.buildUrl(
          "dailyrecords/getAllDailyRecordOfWeekByDate?date=$date"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> deleteMealLogByID(int? mealLogID) async {
    var response = await client.delete(
      BuildServer.buildUrl("meallog/delete?mealLogID=$mealLogID"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 20));
    return response;
  }
}
