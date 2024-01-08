import 'dart:convert';

import 'package:flutter_health_menu/models/schedule_model.dart';
import 'package:http/http.dart' as http;

import '../config/build_server.dart';

class ScheduleRepository {
  static final client = http.Client();

  static getScheduleById(String endpoint) async {
    var response = await client.post(
      BuildServer.buildUrl(endpoint),
      headers: {"Content-type": "application/json"},
    );
    // print('${response.statusCode}: ${response.body}');
    return scheduleFromJson(response.body);
  }
}
