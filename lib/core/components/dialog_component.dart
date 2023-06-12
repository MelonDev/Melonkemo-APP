import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/color_extension.dart';
import 'package:shimmer/shimmer.dart';

class DialogComponent {
  loadingSimple() {
    BotToast.showLoading();
  }

  loading() {
    BotToast.showWidget(
      toastBuilder: (CancelFunc cancelFunc) {
        return Container(
          color: Colors.black.withOpacity(0.4),
          child: Center(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(14)),
                      height: 200,
                      width: double.infinity,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitThreeBounce(
                              size: 40, color: Colors.white),
                          SizedBox(
                            height: 30,
                          ),
                          Material(
                              color: Colors.transparent,
                              child: Text(
                                'กำลังโหลดข้อมูล..',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontFamily: 'Itim',
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      )))),
        );
      },
    );
  }

  test2() {
    BotToast.showCustomLoading(
        toastBuilder: (CancelFunc cancelFunc) {
          return Container(
              decoration: BoxDecoration(
                  color: const Color(0x00F0F0F0).withOpacity(1),
                  borderRadius: BorderRadius.circular(14)),
              height: 70,
              width: 70,
              child: const SpinKitThreeBounce(size: 40, color: Colors.black));
        },
        backgroundColor: Colors.black);
  }

  notify(String value, {Color? color, Color? onColor}) {
    BotToast.cleanAll();
    BotToast.showSimpleNotification(
        titleStyle:
            TextStyle(color: onColor ?? Colors.white, fontFamily: 'Itim'),
        title: value,
        backgroundColor: color ?? Colors.blueAccent,
        closeIcon: Icon(Icons.cancel, color: onColor ?? Colors.white));
  }

  test(String value) {
    Color textColor = Colors.redAccent.darken(.4);
    BotToast.showWidget(
      toastBuilder: (CancelFunc cancelFunc) {
        return GestureDetector(
          onTap: cancelFunc,
          child: Container(
            color: textColor.withOpacity(0.6),
            child: Center(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Colors.red.darken(.3).withOpacity(0.3),
                                    blurRadius: 20)
                              ]),
                          width: 300,
                          padding: const EdgeInsets.only(
                              left: 16, top: 14, right: 16, bottom: 14),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("แจ้งเตือน",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 22,
                                    fontFamily: 'Itim',
                                    fontWeight: FontWeight.w900,
                                  )),
                              const SizedBox(height: 6),
                              Text(value,
                                  style: TextStyle(
                                    color: textColor.withOpacity(0.6),
                                    fontSize: 16,
                                    fontFamily: 'Itim',
                                    fontWeight: FontWeight.w900,
                                  )),
                              const SizedBox(height: 20),
                              Container(
                                height: 1,
                                color: textColor.withOpacity(0.1),
                              ),
                              const SizedBox(height: 16),
                              MelonBouncingButton.text(
                                  enabledHover: true,
                                  text: "ปิด",
                                  textColor: textColor,
                                  callback: cancelFunc)
                            ],
                          )),
                    ))),
          ),
        );
      },
    );
  }

  error(String value) {
    notify(value, color: Colors.redAccent);
  }
}
