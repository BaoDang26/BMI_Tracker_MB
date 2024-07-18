import 'package:flutter_health_menu/repository/jwt_interceptor.dart';
import 'package:http/http.dart' as http;
import '../config/build_server.dart';
import 'dart:async';

class NotificationRepository {
  static Future<http.Response> getAllNotification() async {
    http.Response response;

    Map<String, String> header = {
      "Content-type": "application/json",
    };
    response = await interceptedClient.get(
      BuildServer.buildUrl("notifications/get-all-for-user"),
      headers: header,
    );
    return response;
  }
}
