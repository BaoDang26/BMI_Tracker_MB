import 'dart:convert';

import 'package:flutter_health_menu/config/build_server.dart';
import 'package:flutter_health_menu/screens/activity/model/activity_log_request.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../screens/meal/model/meal_log_request.dart';
import '../util/preUtils.dart';

class DailyRecordRepository {
  static Future<http.Response> fetchCaloriesOfMeal(String date) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("meallog/getCaloriesOfMeal?date=$date"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAllActivityLogByDate(String date) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("activitylog/getAllByDate?date=$date"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAllMelLogOfDateByMealType(
      String date, String mealType) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl(
          "meallog/getAllMelLogOfDateByMealType?date=$date&mealType=$mealType"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> createMealLog(
      MealLogRequest mealLogRequest) async {
    var response = await interceptedClient
        .post(BuildServer.buildUrl("meallog/createNew"),
            headers: {
              "Content-type": "application/json",
            },
            body: json.encode(mealLogRequest.toJson()))
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getDailyRecordInWeek(String date) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl(
          "dailyrecords/getAllDailyRecordOfWeekByDate?date=$date"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> deleteMealLogByID(int? mealLogID) async {
    var response = await interceptedClient.delete(
      BuildServer.buildUrl("meallog/delete?mealLogID=$mealLogID"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 20));
    return response;
  }

  static Future<http.Response> createActivityLog(
      ActivityLogRequest activityLogModel) async {
    var response = await interceptedClient
        .post(BuildServer.buildUrl("activitylog/createNew"),
            headers: {
              "Content-type": "application/json",
            },
            body: json.encode(activityLogModel.toJson()))
        .timeout(const Duration(seconds: 20));
    return response;
  }

  static Future<http.Response> deleteActivityLogByID(activityLogID) async {
    var response = await interceptedClient.delete(
      BuildServer.buildUrl("activitylog/delete?activityLogID=$activityLogID"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 20));
    return response;
  }

  static Future<http.Response> updateMealLog(
      Map<String, String> mealLogUpdate) async {
    var response = await interceptedClient
        .put(
          BuildServer.buildUrl("meallog/update"),
          headers: {
            "Content-type": "application/json",
          },
          body: jsonEncode(mealLogUpdate),
        )
        .timeout(const Duration(seconds: 20));
    return response;
  }
}
