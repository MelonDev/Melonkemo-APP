import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:melonkemo/core/components/bouncing/on_hover.dart';
import 'package:melonkemo/core/core/core_route.dart';

extension WidgetExtension on Widget {
  Widget hover({
    double x = -5.0,
    double y = -1.0,
    double z = 1.04,
    enabledHover = true,
  }) {
    return OnHover(
        x: x,
        y: y,
        z: z,
        disableScale: !enabledHover,
        builder: (isHover) {
          return this;
        });
  }

  RouteBase route(String path) => CoreRoute.page(path, this);

  dialog(BuildContext context, {double? borderRadius}) {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20.0)),
      child: this,
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

}
