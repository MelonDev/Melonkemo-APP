import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:melonkemo/core/extensions/string_extension.dart';

class DioHelper {
  static const String _baseUrl = "https://api.melonkemo.com/v1/melonkemo";

  DioHelper({required this.dio});

  final Dio dio;

  static Future<DioHelper> init() async {
    DioHelper dio = DioHelper(dio: Dio());
    await dio.initializeToken();
    return dio;
  }

  String token = "";
  FlutterSecureStorage storage = const FlutterSecureStorage();

  initializeToken() async {
    String? user_uid = await storage.read(key: "user_uid".toUpperCase());
    //print("user_uid: $user_uid");

    String? accessToken = await storage.read(key: "access_token".toUpperCase());
    //print("accessToken: $accessToken");
    token = accessToken ?? "";
    //print("token: $token");

    initApiClient();
  }

  Future<void> initApiClient() async {
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
          onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            options.headers['Authorization'] = token.bearer;
            return handler.next(options); //continue
          },
          onResponse: (Response response, ResponseInterceptorHandler handler) =>
              handler.next(response),
          onError: onError),
    );
    dio.options.baseUrl = _baseUrl;
  }

  // Future<void> initApiClient() async {
  //   dio.interceptors.clear();
  //   dio.interceptors.add(InterceptorsWrapper(
  //       onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
  //     options.headers['Authorization'] = token.bearer;
  //
  //     return handler.next(options); //continue
  //   }, onResponse: (Response response, ResponseInterceptorHandler handler) {
  //     return handler.next(response); // continue
  //   }, onError: (DioError error, ErrorInterceptorHandler handler) async {
  //     if (error.response != null) {
  //       var response = error.response!;
  //       if (response.statusCode == 401) {
  //         try {
  //           String? refreshToken =
  //               await storage.read(key: "refresh_token".toUpperCase());
  //           dio.options.headers['Authorization'] = refreshToken.bearer;
  //
  //           Dio anotherDio = Dio();
  //           anotherDio.options.headers['Authorization'] = refreshToken.bearer;
  //
  //           Response<dynamic> data =
  //               await anotherDio.post("$_baseUrl/core/refresh-token");
  //           String newToken = data.data['access_token'];
  //           token = newToken;
  //           await storage.write(
  //               key: "access_token".toUpperCase(), value: newToken);
  //
  //           response.requestOptions.headers['Authorization'] =
  //               "Bearer $newToken";
  //
  //           Response newResponse = await anotherDio.request(
  //               "$_baseUrl${error.requestOptions.path}",
  //               options: Options(
  //                   method: error.requestOptions.method,
  //                   headers: error.requestOptions.headers),
  //               data: error.requestOptions.data,
  //               queryParameters: error.requestOptions.queryParameters);
  //
  //           return handler.resolve(newResponse);
  //         } catch (err) {
  //           return handler.next(error); //continue
  //         }
  //       }
  //     }
  //     return handler.next(error); //continue
  //   }));
  //   dio.options.baseUrl = _baseUrl;
  // }

  onError(DioError error, ErrorInterceptorHandler handler) async {
    try {
      if (error.response != null) {
        Response response = error.response!;
        if (response.statusCode == 401) {
          Dio dio = Dio();
          String? refreshToken = await _refreshToken;
          dio.options.headers['Authorization'] = refreshToken.bearer;
          String? newToken = await _getNewAccessToken(dio, refreshToken);
          bool isSuccess = await _saveAccessToken(newToken);

          if (isSuccess == false) return null;

          response.requestOptions.headers['Authorization'] = newToken.bearer;
          Response? newRes = await _callNewRequest(dio, error.requestOptions);
          if (newRes == null) return null;
          return handler.resolve(newRes);
        } else if (response.statusCode == 418) {

        }
      }
      return handler.next(error);
    } catch (e) {
      return null;
    }
  }

  Future<Response?> _callNewRequest(
      Dio targetDio, RequestOptions options) async {
    return await targetDio.request("$_baseUrl${options.path}",
        options: Options(method: options.method, headers: options.headers),
        data: options.data,
        queryParameters: options.queryParameters);
  }

  Future<String?> _getNewAccessToken(
      Dio targetDio, String? refreshToken) async {
    try {
      targetDio.options.headers['Authorization'] = refreshToken.bearer;
      Response<dynamic> data =
          await targetDio.post("$_baseUrl/core/refresh-token");
      return data.data['access_token'];
    } catch (e) {
      return null;
    }
  }

  Future<bool> _saveAccessToken(String? newToken) async {
    if (newToken == null) return false;
    token = newToken;
    await storage.write(key: "access_token".toUpperCase(), value: newToken);
    return true;
  }

  Future<String?> get _refreshToken async {
    return await storage.read(key: "refresh_token".toUpperCase());
  }

  Future<dynamic> get(String url,
      {required data, Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.get(url,
          queryParameters: data,
          options: headers != null ? Options(headers: headers) : null);
      return response;
    } on DioError catch (e) {
      print('[Dio Helper - GET] Connection Exception => ${e.message}');
      rethrow;
    }
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic>? headers, required data, encoding}) async {
    try {
      final response =
          await dio.post(url, data: data, options: Options(headers: headers));

      print(response);

      return response;
    } on DioError catch (e) {
      print('[Dio Helper - GET] Connection Exception => ${e.message}');
      rethrow;
    }
  }
}
