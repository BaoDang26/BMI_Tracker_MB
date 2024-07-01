import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_health_menu/config/build_server.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final client = http.Client();

  Future<void> init() async {
    // Lấy token hiện tại
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await _saveToken(token);
    }

    // Nghe sự kiện token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print('accountTOken: $newToken');
      await _saveToken(newToken);
    });

    // Cài đặt xử lý thông báo khi ứng dụng đang mở
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      Get.snackbar("title", "${message.data}");
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Xử lý khi người dùng nhấp vào thông báo
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  Future<void> _saveToken(String token) async {
    String? storedToken = await _getTokenFromLocalStorage();
    if (storedToken != token) {
      await _sendTokenToServer(token);
      await _storeTokenLocally(token);
    }
  }

  Future<void> _sendTokenToServer(String token) async {
    Map<String, String> header = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${PrefUtils.getAccessToken()}'
    };
    var response = await client
        .put(
          BuildServer.buildUrl(
              "accounts/update-device-token?deviceToken=$token"),
          headers: header,
          body: jsonEncode({'fcmToken': token}),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      print('Token saved successfully');
    } else {
      print('Failed to save token');
    }
  }

  Future<void> _storeTokenLocally(String token) async {
    await PrefUtils.setString('fcm_token', token);
  }

  Future<String?> _getTokenFromLocalStorage() async {
    return PrefUtils.getString('fcm_token');
  }

  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();
  }
}
