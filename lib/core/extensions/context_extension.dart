import 'package:flutter/widgets.dart';
import 'package:layout/layout.dart';

extension ContextExtension on BuildContext {
  CurrentLayoutValue? get contextWidth {
    double? value = layout.format.breakpoints[layout.breakpoint];
    if (value == null) return null;
    return CurrentLayoutValue(layoutBreakpoint: layout.breakpoint,
        value: value);
  }
}

class CurrentLayoutValue {
  final LayoutBreakpoint layoutBreakpoint;
  final double value;

  CurrentLayoutValue({required this.layoutBreakpoint, required this.value});
}