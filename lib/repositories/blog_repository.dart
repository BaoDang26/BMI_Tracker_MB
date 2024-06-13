import 'dart:async';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;

import '../util/preUtils.dart';

class BlogRepository {
  static final client = http.Client();

  static Future<http.Response> getBlogByAdvisorId(int advisorID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
    };
    var response = await client
        .get(BuildServer.buildUrl('blogs/getAllByAdvisorID/$advisorID'),
            headers: header)
        .timeout(const Duration(seconds: 30));

    return response;
  }
}
