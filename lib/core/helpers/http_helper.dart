import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'dio_helper.dart';


class HttpHelper {
  static const String _baseUrl = "https://api.melonkemo.com/v1/melonkemo";

  static const Map<String, String> headers = {
    //'Authorization': 'Basic cGRhX2FwcDpzZWNyZXRrZXk=',
    //'x-api-key': 'ASMjY6HQ4TyV7R11e0w9Dn4WNrheY0YE',
    'Content-Type': 'application/json'
    //'Content-Type': 'application/x-www-form-urlencoded'
  };

  static Future<http.StreamedResponse?> get(
      {required String path, Map<String, String>? body, String? url}) async {
    try {
      print("GET: $url");
      print("BODY: $body");
      String masterUrl = url ?? _baseUrl;
      var request = http.Request('GET', Uri.parse('$masterUrl$path'));
      if (body != null) {
        request.body = json.encode(body);
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<Response?> getForm(
      {required String path, Map<String, String>? body}) async {
    try {
      print("getForm");
      var formData = FormData.fromMap(body ?? {});
      DioHelper dio = await DioHelper.init();
      var response = await dio.get(path, data: body);
      print(response);

      return response;
    } on Exception catch (e) {
      if (e is DioError) {
        print(e.message);
        print(e.response?.statusCode);
        print(e.response?.data);
      } else {
        print(e);
      }
      return null;
    }
  }

  static Future<http.StreamedResponse?> post(
      {required String path, Map<String, String>? body}) async {
    try {
      var request = http.Request('POST', Uri.parse('$_baseUrl$path'));
      if (body != null) {
        request.body = json.encode(body);
      }
      request.headers.addAll({

      });
      http.StreamedResponse response = await request.send();
      return response;
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<Response?> postForm(
      {required String path, Map<String, dynamic>? body}) async {
    try {
      var formData = FormData.fromMap(body ?? {});
      DioHelper dio = await DioHelper.init();

      var response = await dio.post(path, data: formData);
      print(response);

      return response;
    } on Exception catch (e) {
      if (e is DioError) {
        print("message");
        print(e.message);
        print("e.response?.statusCode");
        print(e.response?.statusCode);
        print("e.response?.data");
        print(e.response?.data);
        return e.response;
      } else {
        print(e);
      }
      return null;
    }
  }
}