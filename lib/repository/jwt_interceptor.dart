import 'dart:convert';

import 'package:flutter_health_menu/config/jwt_service.dart';
import 'package:flutter_health_menu/controllers/profile_controller.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

class JwtInterceptor implements InterceptorContract {
  final client = http.Client();

  final JwtService _jwtService = JwtService();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String? accessToken = PrefUtils.getAccessToken();
    if (accessToken != null) {
      data.headers['Authorization'] = 'Bearer $accessToken';
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      try {
        // gọi jwt service để lấy access token mới
        await _jwtService.refreshAccessToken();
        String? newAccessToken = PrefUtils.getAccessToken();
        if (newAccessToken != null) {
          // Retry the original request with the new access token
          return await retryRequest(data.request!, newAccessToken);
        }
      } catch (e) {
        print('Failed refresh token');
        logout();
      }
    }
    return data;
  }

  Future<ResponseData> retryRequest(
      RequestData requestData, String accessToken) async {
    // Convert Method to String
    String method = _methodToString(requestData.method);

    // Convert URL String to Uri
    Uri url = Uri.parse(requestData.url);

    // Build the new request
    final newRequest = http.Request(method, url)
      ..headers.addAll(requestData.headers)
      ..headers['Authorization'] = 'Bearer $accessToken';

    // Convert body to bytes if it exists
    if (requestData.body != null) {
      newRequest.bodyBytes = utf8.encode(requestData.body!);
    }

    // Add body if it's a PUT or POST request
    if (method == 'PUT' || method == 'POST') {
      if (requestData.body != null) {
        newRequest.bodyBytes = requestData.body!;
      }
    }

    // Send the new request
    final streamResponse = await client.send(newRequest);
    final http.Response response =
        await http.Response.fromStream(streamResponse);

    return ResponseData.fromHttpResponse(response);
  }

  Future<void> logout() async {
    // Alert.showLoadingIndicatorDialog(context);
    PrefUtils.clearPreferencesData();
    await AccountRepository.logout();

    // Navigator.of(context).pop();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  String _methodToString(Method method) {
    switch (method) {
      case Method.GET:
        return 'GET';
      case Method.POST:
        return 'POST';
      case Method.PUT:
        return 'PUT';
      case Method.DELETE:
        return 'DELETE';
      case Method.PATCH:
        return 'PATCH';
      case Method.HEAD:
        return 'HEAD';
      default:
        return 'GET';
    }
  }
}

final jwtInterceptor = JwtInterceptor();
final interceptedClient =
    InterceptedClient.build(interceptors: [jwtInterceptor]);
