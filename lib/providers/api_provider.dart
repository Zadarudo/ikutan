import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ikutan/env/env.dart';
import 'package:ikutan/utils/const.dart';

class ApiProvider extends GetConnect {
  final _storage = FlutterSecureStorage();
  @override
  void onInit() {
    httpClient.baseUrl = Const.baseApiUrl;
    httpClient.defaultContentType = 'application/json';

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await _storage.read(key: Const.tokenKey);
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      // request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['X-API-KEY'] = Env.apiKey;
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      log('=== RESPONSE DEBUG ===');
      log('URL: ${request.url}');
      log('Status: ${response.statusCode}');
      log('Body: ${response.body}');
      log('======================');
      log('API KEY BEING SENT: ${Env.apiKey}');
      log('HEADERS BEING SENT: ${request.headers}');
      return response;
    });

    super.onInit();
  }

  Future<Response> logout() async {
    return post('/logout', {});
  }
}
