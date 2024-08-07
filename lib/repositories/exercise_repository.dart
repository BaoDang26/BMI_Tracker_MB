import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_health_menu/repository/jwt_interceptor.dart';

import '../config/build_server.dart';

class ExerciseRepository {
  static Future<http.Response> getExerciseByID(int exerciseID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };

    http.Response response = await interceptedClient.get(
      headers: header,
      BuildServer.buildUrl('exercises/getByID?exerciseID=$exerciseID'),
    );
    return response;
  }
}
