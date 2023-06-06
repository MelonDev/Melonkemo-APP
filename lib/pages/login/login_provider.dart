import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:melonkemo/core/helpers/dio_helper.dart';
import 'package:melonkemo/core/helpers/http_helper.dart';
import 'package:melonkemo/models/authentication/login_response_model.dart';

class LoginProvider with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  login({required String username,required String password}) async {
    Map<String, String> body = {
      "username": username,
      "password": password
    };
    try {
      var response = await HttpHelper.postForm(path: '/core/login', body: body);
      if (response != null) {
        if (response.statusCode == 200) {
          LoginResponseModel? result = LoginResponseModel.fromJson(response.data);
          await storage.write(key: "access_token".toUpperCase(), value: result.access_token);

          var response1 = await HttpHelper.getForm(path: '/core/me');
          BotToast.showSimpleNotification(titleStyle: const TextStyle(color: Colors.white),title: "Welcome: ${response1?.data['username']}",backgroundColor: Colors.blueAccent);

        }else {
          BotToast.showSimpleNotification(titleStyle: const TextStyle(color: Colors.white),title: "Error: ${response.data}",backgroundColor: Colors.redAccent);
        }
      }
    } catch (e) {
      BotToast.showSimpleNotification(titleStyle: const TextStyle(color: Colors.white),title: "Catch: $e",backgroundColor: Colors.redAccent);
    }

  }
}
