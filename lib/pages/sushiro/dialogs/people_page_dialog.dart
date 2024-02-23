import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';


WoltModalSheetPage peoplePage(
    BuildContext modalSheetContext, TextTheme textTheme,PeopleModel people) {
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
          ? size.resolve(modalSheetContext).height * 0.92
          : size.resolve(modalSheetContext).height * 0.85,
      child: Column(
    children: [
    Container(
    height: 56,
      padding: const EdgeInsets.only(left: 20, right: 20),

      //color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "เพื่มคน",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Itim',
                color: Colors.black),
          ),
        ],
      ),
    ),
    Expanded(
      child: Container(),
    ),
    Container(
        padding: EdgeInsets.only(bottom:16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MelonBouncingButton(
                  callback: (){
                    Navigator.of(modalSheetContext).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      "ยกเลิก",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Itim',
                          color: Colors.black),
                    ),
                    padding: EdgeInsets.only(
                        left: 60, right: 60, bottom: 12, top: 12),
                  ),
                  borderRadius: 100),
              MelonBouncingButton(
                  callback: (){
                    Navigator.of(modalSheetContext).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      "บันทึก",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Itim',
                          color: Colors.black),
                    ),
                    padding: EdgeInsets.only(
                        left: 60, right: 60, bottom: 12, top: 12),
                  ),
                  borderRadius: 100),
            ]))
    ],
  ),
    ),
  );
}