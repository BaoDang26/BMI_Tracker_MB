import 'dart:async';

import '../config/build_server.dart';
import 'package:http/http.dart' as http;

import '../util/preUtils.dart';

class BlogRepository {
  static final client = http.Client();

  static Future<String> getBlogByAdvisorId(String endpoint) async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
      };
      var response = await client
          .get(
            BuildServer.buildUrl(endpoint),
          )
          .timeout(const Duration(seconds: 30));
      return response.body;
    } on TimeoutException catch (e) {
      return e.toString();
    }
  }
  // static Future<String> getBlogByAdvisorId() async {
  //   try {
  //     Map<String, String> header = {
  //       "Content-type": "application/json",
  //       'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
  //     };
  //     var response = await client.get(
  //         BuildServer.buildUrl('blogs/getAllByAdvisorID/2'),
  //         headers: header);
  //     return response.body;
  //   } on TimeoutException catch (e) {
  //     return e.toString();
  //   }
  // }
}
