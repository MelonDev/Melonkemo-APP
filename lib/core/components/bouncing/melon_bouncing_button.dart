import 'package:flutter/material.dart';

import 'melon_bounce_widget.dart';
import 'on_hover.dart';

class MelonBouncingButton extends StatelessWidget {
  MelonBouncingButton(
      {super.key,
      required this.child,
      this.callback,
      this.active,
      this.isBouncing,
      this.borderRadius,
      this.fakeLongEnable = true,
      this.isHover = false});

  static Widget init(
      {enabledHover = false,
      required Widget child,
      VoidCallback? callback,
      bool? active,
      bool? isBouncing,
      bool fakeLongEnable = true,
      double? borderRadius}) {
    return OnHover(
      disableScale: !enabledHover,
      builder: (isHover) {
        return MelonBouncingButton(
            callback: callback,
            active: active,
            isBouncing: isBouncing,
            fakeLongEnable: fakeLongEnable,
            borderRadius: borderRadius,
            isHover: isHover,
            child: child);
      },
    );
  }

  static Widget text(
      {enabledHover = false,
      required String text,
      VoidCallback? callback,
      bool? active,
      bool? isBouncing,
      Color? color,
      Color? textColor,
      double height = 36,
      double? fontSize,
      bool fakeLongEnable = true,
      double? borderRadius}) {
    return OnHover(
      x: -5.0,
      y: -1.0,
      z: 1.04,
      disableScale: !enabledHover,
      builder: (isHover) {
        return MelonBouncingButton(
            callback: callback,
            active: active,
            isBouncing: isBouncing,
            fakeLongEnable: fakeLongEnable,
            borderRadius: borderRadius,
            isHover: isHover,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.black,
                    fontSize: fontSize,
                    fontFamily: 'Itim',
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ));
      },
    );
  }

  Widget child;

  VoidCallback? callback;
  bool? active;
  bool? isBouncing;
  bool fakeLongEnable;
  double? borderRadius;
  bool isHover;

  @override
  Widget build(BuildContext context) {
    return MelonBounceWidget(
        borderRadius: borderRadius,
        duration:
            Duration(milliseconds: active != null ? (active! ? 96 : 0) : 96),
        fakeLongEnable: fakeLongEnable,
        onPressed: () {
          if (callback != null) {
            callback?.call();
          }
        },
        scaleFactor: isBouncing != null ? (isBouncing! ? 1.5 : 0) : 1.5,
        child: child);
  }
}
