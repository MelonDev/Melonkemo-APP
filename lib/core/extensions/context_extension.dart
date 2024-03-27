import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';

extension ContextExtension on BuildContext {
  CurrentLayoutValue? get contextWidth {
    double? value = layout.format.breakpoints[layout.breakpoint];
    if (value == null) return null;
    return CurrentLayoutValue(
        layoutBreakpoint: layout.breakpoint, value: value);
  }

  confirmDialog(
    String message, {
    String title = "แจ้งเตือน",
    VoidCallback? onTapNegative,
    VoidCallback? onTapPositive,
        Color? positiveColor,
        Color? positiveTextColor,

      }) {
    Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      constraints: const BoxConstraints(maxWidth: 360),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Bai',
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 16, top: 16),
              child: Text(
                message,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Bai',
                    color: Colors.black),
              )),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 16, top: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: MelonBouncingButton(
                            callback: () {
                              Navigator.of(this).pop();
                              onTapNegative?.call();
                            },
                            borderRadius: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(100)),
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 12, top: 12),
                              alignment: Alignment.center,
                              child: const Text(
                                "ยกเลิก",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Bai',
                                    color: Colors.black),
                              ),
                            ))),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MelonBouncingButton(
                        callback: () {
                          Navigator.of(this).pop();
                          onTapPositive?.call();
                        },
                        borderRadius: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: positiveColor ?? Colors.amberAccent,
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, bottom: 12, top: 12),
                          alignment: Alignment.center,
                          child: Text(
                            "ยืนยัน",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Bai',
                                color: positiveTextColor ?? Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ]))
        ],
      ),
    ).dialog(this);
  }
}

class CurrentLayoutValue {
  final LayoutBreakpoint layoutBreakpoint;
  final double value;

  CurrentLayoutValue({required this.layoutBreakpoint, required this.value});
}
