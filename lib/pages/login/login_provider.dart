import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:melonkemo/core/extensions/bot_toast_extension.dart';
import 'package:melonkemo/core/helpers/http_helper.dart';
import 'package:melonkemo/models/authentication/login_response_model.dart';

class LoginProvider with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  login({required String username, required String password}) async {
    Map<String, String> body = {"username": username, "password": password};
    try {
      //BotToast().component.loadingSimple();
      BotToast().component.loading();
      var response =
          await HttpHelper.postUrlEncode(path: '/core/login', body: body);
      if (response != null) {
        if (response.statusCode == 200) {
          LoginResponseModel? result =
              LoginResponseModel.fromJson(response.data);
          await storage.write(
              key: "access_token".toUpperCase(), value: result.access_token);

          var responseMe = await HttpHelper.get(path: '/core/me');
          BotToast().component.notify("Welcome: ${responseMe?.data['username']}");
        } else {
          BotToast().component.error("Error: ${response.data}");
        }
      }

    } catch (e) {
      BotToast.cleanAll();
      BotToast.showSimpleNotification(
          titleStyle: const TextStyle(color: Colors.white),
          title: "Catch: $e",
          backgroundColor: Colors.redAccent,
          closeIcon: const Icon(Icons.cancel, color: Colors.white));
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
