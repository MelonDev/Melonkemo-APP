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

  // static Future<http.StreamedResponse?> get(
  //     {required String path, Map<String, String>? body, String? url}) async {
  //   try {
  //     String masterUrl = url ?? _baseUrl;
  //     var request = http.Request('GET', Uri.parse('$masterUrl$path'));
  //     if (body != null) {
  //       request.body = json.encode(body);
  //     }
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //
  //     return response;
  //   } on Exception catch (_) {
  //     return null;
  //   }
  // }

  static Future<Response?> get({required String path, Map<String, String>? body}) async {
    try {
      DioHelper dio = await DioHelper.init();
      final response = await dio.get(path, data: body);
      return response;
    } on Exception catch (e) {
      return null;
    }
  }

  static Future<Response?> getForm(
      {required String path, Map<String, String>? body}) async {
    try {
      DioHelper dio = await DioHelper.init();
      var response = await dio.get(path, data: body);

      return response;
    } on Exception catch (e) {
      return null;
    }
  }

  // static Future<http.StreamedResponse?> post(
  //     {required String path, Map<String, String>? body}) async {
  //   try {
  //     var request = http.Request('POST', Uri.parse('$_baseUrl$path'));
  //     if (body != null) {
  //       request.body = json.encode(body);
  //     }
  //     request.headers.addAll({});
  //     http.StreamedResponse response = await request.send();
  //     return response;
  //   } on Exception catch (_) {
  //     return null;
  //   }
  // }

  static Future<Response?> post(
      {required String path, Map<String, dynamic>? body}) async {
    try {
      DioHelper dio = await DioHelper.init();
      var response = await dio.post(path, data: body);
      return response;
    } on Exception catch (e) {
      if (e is DioError) {
        return e.response;
      }
      return null;
    }
  }

  static Future<Response?> postUrlEncode(
      {required String path, Map<String, dynamic>? body}) async {
    try {
      FormData formData = FormData.fromMap(body ?? {});
      DioHelper dio = await DioHelper.init();
      var response = await dio.post(path, data: formData);
      return response;
    } on Exception catch (e) {
      if (e is DioError) {
        return e.response;
      }
      return null;
    }
  }
}
