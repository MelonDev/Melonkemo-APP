import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/color_extension.dart';

import 'animations/custom_offset_animation.dart';

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
                          SpinKitThreeBounce(size: 40, color: Colors.white),
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

  notify(String value, {Color? color, Color? onColor}) {
    BotToast.cleanAll();
    BotToast.showSimpleNotification(
        titleStyle:
            TextStyle(color: onColor ?? Colors.white, fontFamily: 'Itim'),
        title: value,
        backgroundColor: color ?? Colors.blueAccent,
        closeIcon: Icon(Icons.cancel, color: onColor ?? Colors.white));
  }

  dialog(String value, {Color? color, bool fullscreenMode = false}) {
    BotToast.showAnimationWidget(
      wrapToastAnimation: (controller, cancel, child) => Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //cancel();
            },
            child: AnimatedBuilder(
              builder: (_, child) => Opacity(
                opacity: controller.value,
                child: child,
              ),
              animation: controller,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black26),
                child: SizedBox.expand(),
              ),
            ),
          ),
          CustomOffsetAnimation(
            controller: controller,
            child: child,
          )
        ],
      ),
      toastBuilder: (CancelFunc cancelFunc) {
        return GestureDetector(
          onTap: cancelFunc,
          child: Container(
            //color: textColor.withOpacity(0.6),
            child: Center(
                child: _dialog(value,
                    fullscreenMode: fullscreenMode,
                    color: color,
                    cancelFunc: cancelFunc)),
          ),
        );
      }, animationDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _blurDialog(String value,
      {Color? color, required CancelFunc cancelFunc}) {
    Color themeColor = color ?? Colors.black;
    Color onColor = themeColor.darken(.3);
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 2, color: themeColor.darken(.3))),
              width: 300,
              padding: const EdgeInsets.only(
                  left: 16, top: 14, right: 16, bottom: 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  Text("แจ้งเตือน",
                      style: TextStyle(
                        color: onColor,
                        fontSize: 24,
                        fontFamily: 'Itim',
                        fontWeight: FontWeight.w900,
                      )),
                  const SizedBox(height: 26),
                  Text(value,
                      style: TextStyle(
                        color: onColor.withOpacity(0.8),
                        fontSize: 18,
                        fontFamily: 'Itim',
                        fontWeight: FontWeight.normal,
                      )),
                  const SizedBox(height: 40),
                  Container(
                    height: 2,
                    color: onColor.withOpacity(0.2),
                  ),
                  const SizedBox(height: 16),
                  MelonBouncingButton.text(
                      enabledHover: true,
                      text: "ปิด",
                      color: onColor,
                      fontSize: 16,
                      textColor: Colors.white,
                      callback: cancelFunc)
                ],
              )),
        ));
  }

  Widget _dialog(String value,
      {bool fullscreenMode = false,
      Color? color,
      required CancelFunc cancelFunc}) {
    Color themeColor = color ?? Colors.black;
    Widget childWidget =
        _blurDialog(value, color: color, cancelFunc: cancelFunc);

    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: themeColor.darken(.3).withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 10)
          ]),
      child: fullscreenMode
          ? childWidget
          : ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: childWidget,
            ),
    );
  }

  error(String value) {
    notify(value, color: Colors.redAccent);
  }
}