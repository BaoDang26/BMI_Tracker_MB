import 'dart:async';

import 'package:http/http.dart' as http;

import '../config/build_server.dart';
import '../util/preUtils.dart';

class MemberBodyMassRepository {
  static final client = http.Client();

  static Future<String> postMemberBodyMass(var body, String endpoint) async {
    try {
      var response = await client.post(
        BuildServer.buildUrl(endpoint),
        body: body,
        headers: {"Content-type": "application/json"},
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<String> getMemberBodyMass(String endpoint) async {
    try {
      var response = await client.get(
        BuildServer.buildUrl(endpoint),
        headers: {"Content-type": "application/json"},
      ).timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<http.Response> getAllBodyMassLast30Days(String date) async {
    var response = await client.get(
      BuildServer.buildUrl("bodymass/member/getInMonth?date=$date"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }
}
