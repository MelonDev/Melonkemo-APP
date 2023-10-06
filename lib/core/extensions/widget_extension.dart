import 'package:flutter/widgets.dart';
import 'package:melonkemo/core/components/bouncing/on_hover.dart';

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
}
