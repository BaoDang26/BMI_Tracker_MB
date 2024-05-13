import 'dart:async';

import 'package:flutter_health_menu/constants/preUtils.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class UserRepository {
  static final client = http.Client();

  static Future<String> postLogin(var body, String endpoint) async {
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

  static Future<String> registerUser(var body, String endpoint) async {
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

  static Future<String> getListTrainer() async {
    try {
      var response = await client.get(
        BuildServer.buildUrl('user/trainer'),
        headers: {"Authorization": "Bearer ${PrefUtils.getAccessToken()}"}
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }

  static Future<String> getUserMenuId(String userId) async {
    try {
      var response = await client.get(
        BuildServer.buildUrl('user/getMenuByUserId?userId=$userId'),
      );
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  } // static Future<String> registerUser(String endpoint, var body) async {
//   var respone = await client.post(
//     BuildServer.buildUrl(endpoint),
//     body: body,
//     headers: {"Content-type": "application/json"},
//   );
//   return respone.body;
// }
}
