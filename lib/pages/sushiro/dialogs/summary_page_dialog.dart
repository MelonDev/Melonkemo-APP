import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage summaryPage(
    BuildContext modalSheetContext, TextTheme textTheme) {
  final LayoutValue<Size> size = LayoutValue.builder((layout) {
    return Size(layout.width, layout.size.height);
  });

  return WoltModalSheetPage(
    hasSabGradient: false,
    forceMaxHeight: false,
    navBarHeight: 0,
    backgroundColor: const Color(0xFFFFB920),
    isTopBarLayerAlwaysVisible: false,
    child: Container(
      color: Colors.white,
      height: size.resolve(modalSheetContext).width < 560
          ? size.resolve(modalSheetContext).height * 0.95
          : size.resolve(modalSheetContext).height * 0.85,
      child: Column(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(left: 20, right: 20),

            //color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MelonBouncingButton(
                  callback: () {
                    Navigator.of(modalSheetContext).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      CupertinoIcons.clear,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 46),
                  child: Text(
                    "สรุปยอด",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Itim',
                        color: Colors.black),
                  ),
                ),
                Container()
                // MelonBouncingButton.text(
                //     text: "ยืนยัน",
                //     color: Colors.amberAccent,
                //     fontSize: 18,
                //     padding: EdgeInsets.only(left: 20, right: 20),
                //     borderRadius: 100)
              ],
            ),
          )
        ],
      ),
    ),
  );
}