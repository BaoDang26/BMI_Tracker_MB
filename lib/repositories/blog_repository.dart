import 'dart:async';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';


class BlogRepository {
  static Future<http.Response> getBlogByAdvisorId(int advisorID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .get(BuildServer.buildUrl('blogs/getAllByAdvisorID/$advisorID'),
            headers: header)
        .timeout(const Duration(seconds: 30));

    return response;
  }
}
