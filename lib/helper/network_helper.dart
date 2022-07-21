import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'exception_handler.dart';

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

  NetworkAPICall._internal();

  Future<dynamic> get(String url,
      {Map<String, String>? header, bool isToken = true}) async {
    final client = http.Client();
    try {
      const String fullURL = 'http://ip-api.com/json';
      log('API Url: $fullURL');
      final response = await client.get(Uri.parse(url), headers: header);
      log('Response body: ${response.body}');
      return checkResponse(response);
    } catch (e) {
      client.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          try {
            if (response.body.isEmpty) {
              throw AppException(
                  message: 'Response body is empty', errorCode: 0);
            }
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        default:
          try {
            if (response.body.isEmpty) {
              throw AppException(
                  message: 'Response body is empty',
                  errorCode: response.statusCode);
            }
            final Map<String, dynamic> data = jsonDecode(response.body);
            throw AppException(
                message: "error : ${data['Error']}",
                errorCode: response.statusCode);
          } catch (e) {
            rethrow;
          }
      }
    } catch (e) {
      rethrow;
    }
  }
}
