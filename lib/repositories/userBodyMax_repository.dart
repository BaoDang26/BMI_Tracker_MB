import 'dart:async';
import 'dart:convert';

import 'package:flutter_health_menu/models/userBodyMax_model.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class UserBodyMaxRepository {
  static final client = http.Client();

  static Future<String> postUserBodyMax(var body, String endpoint) async {
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

  static Future<String> getUserBodyMax(String endpoint) async {
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
}
