import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

WoltModalSheetPage peoplePage(
    BuildContext modalSheetContext, TextTheme textTheme, PeopleModel people) {
  final LayoutValue<Size> size = LayoutValue.builder((layout) {
    return Size(layout.width, layout.size.height);
  });

  return WoltModalSheetPage(
    hasSabGradient: false,
    forceMaxHeight: false,
    navBarHeight: 0,
    backgroundColor: Colors.white,
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
                  "รายละเอียด",
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
            child: Container(
                child: ListView(
              children: [
                _plateTileWidget(modalSheetContext, SushiPlateType.copper),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
                ),
                _plateTileWidget(modalSheetContext, SushiPlateType.silver),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
                ),
                _plateTileWidget(modalSheetContext, SushiPlateType.gold),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
                ),
                _plateTileWidget(modalSheetContext, SushiPlateType.black),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                ),
                _sideDishListView(modalSheetContext)
              ],
            )),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MelonBouncingButton(
                        callback: () {
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
                        callback: () {
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

Widget _sideDishListView(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 26, right: 26, top: 6, bottom: 6),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "เมนูอื่น ๆ",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Itim',
                  color: Colors.black),
            ),
            MelonBouncingButton.text(
                enabledHover: true,
                text: "เพิ่มเมนู",
                fontFamily: "Itim",
                textColor: Colors.white,
                fontSize: 16,
                height: 34,
                x: -2,
                borderRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.black.withOpacity(0.8),
                callback: () {})
          ],
        ),

      ],
    ),
  );
}

Widget _plateTileWidget(BuildContext context, SushiPlateType plateType) {
  return Container(
    padding: const EdgeInsets.only(left: 26, right: 26, top: 16, bottom: 16),
    child: Row(
      children: [
        getSushiPlateWidget(plateType),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getSushiPlateName(plateType),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Itim',
                  color: Colors.black),
            ),
            Text(
              "Price",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Itim',
                  color: Colors.black),
            )
          ],
        ),
        Expanded(child: Container()),
        Row(
          children: [
            MelonBouncingButton(
                child: Container(
              height: 38,
              width: 38,
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.minus,
                size: 22,
              ),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100)),
            )).hover(y: -1, x: -0.5),
            const SizedBox(
              width: 20,
            ),
            Text(
              "1",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Itim',
                  color: Colors.black),
            ),
            const SizedBox(
              width: 20,
            ),
            MelonBouncingButton(
                child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.add,
                size: 24,
              ),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(100)),
            )).hover(y: -1, x: -0.5)
          ],
        )
      ],
    ),
  );
}

Widget getSushiPlateWidget(SushiPlateType? type) {
  if (type == SushiPlateType.copper) {
    return plateWidget(getSushiPlateColor(type),
        borderColor: getSushiPlateBorderColor(type));
  } else if (type == SushiPlateType.silver) {
    return plateWidget(getSushiPlateColor(type),
        borderColor: getSushiPlateBorderColor(type));
  } else if (type == SushiPlateType.gold) {
    return plateWidget(getSushiPlateColor(type),
        borderColor: getSushiPlateBorderColor(type));
  } else if (type == SushiPlateType.black) {
    return plateWidget(getSushiPlateColor(type),
        borderColor: getSushiPlateBorderColor(type));
  } else {
    return plateWidget(Colors.transparent,
        borderRadius: 14, borderColor: getSushiPlateBorderColor(type));
  }
}

Color getSushiPlateColor(SushiPlateType? type) {
  if (type == SushiPlateType.copper) {
    return const Color(0xFF7C2A3D);
  } else if (type == SushiPlateType.silver) {
    return const Color(0xFFD7D9D7);
  } else if (type == SushiPlateType.gold) {
    return const Color(0xFFE5C27C);
  } else if (type == SushiPlateType.black) {
    return const Color(0xFF1A1915);
  } else {
    return const Color(0xFFA2A2A2);
  }
}

Color getSushiPlateBorderColor(SushiPlateType? type) {
  if (type == SushiPlateType.copper) {
    return const Color(0xFF591525);
  } else if (type == SushiPlateType.silver) {
    return const Color(0xFFABABAB);
  } else if (type == SushiPlateType.gold) {
    return const Color(0xFFAD8E50);
  } else if (type == SushiPlateType.black) {
    return const Color(0xFF36342C);
  } else {
    return const Color(0xFFA2A2A2);
  }
}

Color getSushiPlateTextColor(SushiPlateType? type) {
  if (type == SushiPlateType.copper) {
    return Colors.white;
  } else if (type == SushiPlateType.silver) {
    return Colors.black;
  } else if (type == SushiPlateType.gold) {
    return Colors.black;
  } else if (type == SushiPlateType.black) {
    return Colors.white;
  } else {
    return const Color(0xFF4D4D4D);
  }
}

String getSushiPlateName(SushiPlateType? type) {
  if (type == SushiPlateType.copper) {
    return "จานแดง";
  } else if (type == SushiPlateType.silver) {
    return "จานเงิน";
  } else if (type == SushiPlateType.gold) {
    return "งานทอง";
  } else if (type == SushiPlateType.black) {
    return "งานดำ";
  } else {
    return "";
  }
}

Widget plateWidget(Color bodyColor,
    {double borderRadius = 100, Color? borderColor}) {
  return Container(
    decoration: BoxDecoration(
        border: borderColor != null
            ? Border.all(color: borderColor, width: 4)
            : null,
        color: bodyColor,
        borderRadius: BorderRadius.circular(borderRadius)),
    width: 60,
    height: 60,
  );
}
