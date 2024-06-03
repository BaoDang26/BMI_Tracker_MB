import 'dart:async';

import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class MemberRepository {
  static final client = http.Client();

  static Future<http.Response> postLogin(var body, String endpoint) async {
    http.Response response;
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      };
      response = await client.post(
        BuildServer.buildUrl(endpoint),
        body: body,
        headers: header,
      );
      return response;
    } finally {}
  }

  static Future<http.Response> registerMember(var body, String endpoint) async {
    var response = await client.post(
      BuildServer.buildUrl(endpoint),
      body: body,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<String> registerAccount(var body, String endpoint) async {
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

  static Future<String> getListAdvisor() async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      };
      var response = await client.get(
          BuildServer.buildUrl('advisors/getWithDetails'),
          headers: header);
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<http.Response> fetchMemberLogged() async {
    var response = await client.get(
      BuildServer.buildUrl("member/getMemberInformation"),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      },
    ).timeout(const Duration(seconds: 30));
    return response;
  }

// static Future<String> getUserMenuId(String userId) async {
//   try {
//     var response = await client.get(
//       BuildServer.buildUrl('user/getMenuByUserId?userId=$userId'),
//     );
//     return response.body;
//   } on TimeoutException catch (e) {
//     return e.toString();
//   }
// } // static Future<String> registerUser(String endpoint, var body) async {
//   var respone = await client.post(
//     BuildServer.buildUrl(endpoint),
//     body: body,
//     headers: {"Content-type": "application/json"},
//   );
//   return respone.body;
// }
}
