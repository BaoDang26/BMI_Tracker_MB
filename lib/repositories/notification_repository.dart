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

  static Future<http.Response> markAsRead(int? notificationID) async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .put(
            BuildServer.buildUrl(
                "notifications/mark-as-read?notificationID=$notificationID"),
            headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }

  static Future<http.Response> readAll() async {
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    var response = await interceptedClient
        .put(BuildServer.buildUrl("notifications/read-all"), headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }
}
