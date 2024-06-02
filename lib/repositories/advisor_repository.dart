import 'dart:async';

import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class AdvisorRepository {
  static final client = http.Client();


  static Future<String> getListAdvisorWithDetails() async {
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
}