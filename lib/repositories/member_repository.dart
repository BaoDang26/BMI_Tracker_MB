import 'package:flutter_health_menu/repository/jwt_interceptor.dart';
import 'package:http/http.dart' as http;
import '../config/build_server.dart';
import 'dart:async';

class MemberRepository {
  static Future<http.Response> postLogin(var body, String endpoint) async {
    http.Response response;

    Map<String, String> header = {
      "Content-type": "application/json",
    };
    response = await interceptedClient.post(
      BuildServer.buildUrl(endpoint),
      body: body,
      headers: header,
    );
    return response;
  }

  static Future<http.Response> registerMember(var body, String endpoint) async {
    var response = await interceptedClient.post(
      BuildServer.buildUrl(endpoint),
      body: body,
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> updateMember(String endpoint) async {
    var response = await interceptedClient.post(
      BuildServer.buildUrl(endpoint),
      headers: {"Content-type": "application/json"},
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> registerAccount(
      var body, String endpoint) async {
    var response = await interceptedClient.post(
      BuildServer.buildUrl(endpoint),
      body: body,
      headers: {"Content-type": "application/json"},
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<String> getListAdvisor() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
      };
      var response = await interceptedClient.get(
          BuildServer.buildUrl('advisors/getWithDetails'),
          headers: header);
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<http.Response> fetchMemberLogged() async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("member/getMemberInformation"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAllFoodWithPaging(
      int page, int size, List<int> tagIDs) async {
    // Construct the base URL
    String baseUrl = "member/foods/getPriority?page=$page&size=$size";

    // Add tagIDs as query parameters if not empty
    if (tagIDs.isNotEmpty) {
      String tagIDsParam = tagIDs.map((id) => 'tagIDs=$id').join('&');
      baseUrl = '$baseUrl&$tagIDsParam';
    }

    var response = await interceptedClient.get(
      BuildServer.buildUrl(baseUrl),
      headers: {
        "Content-type": "application/json;charset=UTF-8",
      },
    ).timeout(const Duration(seconds: 20));

    return response;
  }

  static getAllExerciseWithPaging(int page, int size, int? tagID) async {
    String baseUrl = "member/exercises/getPriority?page=$page&size=$size";

    // Add tagID as query parameters if not empty
    if (tagID != null && tagID != -1) {
      String tagIDParam = "tagID=$tagID";
      baseUrl = '$baseUrl&$tagIDParam';
    }
    var response = await interceptedClient.get(
      BuildServer.buildUrl(baseUrl),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 20));
    return response;
  }

  static Future<http.Response> getMenuByMealType(String mealType) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("member/getMenuByMealType?mealType=$mealType"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getAllWorkoutExerciseInWorkout() async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("member/workout-exercise/getAll"),
      headers: {
        "Content-type": "application/json;charset=UTF-8",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> getDailyRecordByDate(String date) async {
    var response = await interceptedClient.get(
      BuildServer.buildUrl("member/dailyrecord/getByDate?date=$date"),
      headers: {
        "Content-type": "application/json",
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

// static Future<http.Response> getDailyRecordByDate(String date) async {
//   var response = await client.get(
//     BuildServer.buildUrl("member/dailyrecord/getByDate?date=$date"),
//     headers: {
//       "Content-type": "application/json",
//       'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
//     },
//   ).timeout(const Duration(seconds: 30));
//   return response;
// }
}
