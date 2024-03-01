import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/sushiro/dialogs/add_sidedish_dialog.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_page.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class PeoplePageDialog extends StatefulWidget {
  const PeoplePageDialog({super.key, required this.people, this.callback,this.onChangeNameTapped, this.onDeleteTapped});

  final PeopleModel people;
  final Function(PeopleModel)? callback;
  final VoidCallback? onChangeNameTapped;
  final VoidCallback? onDeleteTapped;


  @override
  State<PeoplePageDialog> createState() => _PeoplePageDialogState();
}

class _PeoplePageDialogState extends State<PeoplePageDialog> {
  final LayoutValue<Size> size = LayoutValue.builder((layout) {
    return Size(layout.width, layout.size.height);
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.resolve(context).width < 560
          ? size.resolve(context).height * 0.92
          : size.resolve(context).height * 0.85,
      child: Column(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(left: 20, right: 20),

            //color: Colors.blue,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.people.name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Itim',
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MelonBouncingButton(
                          callback: () {
                            widget.onChangeNameTapped?.call();
                          },
                          child: Container(
                            height: 26,
                            width: 26,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              CupertinoIcons.pencil,
                              size: 18,
                            ),
                          )).hover(y: -1, x: -0.5),
                      const SizedBox(width: 12),
                      MelonBouncingButton(
                          callback: () {
                            widget.onDeleteTapped?.call();
                          },
                          child: Container(
                            height: 26,
                            width: 26,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(1.0),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              CupertinoIcons.trash,
                              size: 14,
                              color: Colors.white,
                            ),
                          )).hover(y: -1, x: -0.5)

                    ],
                  ),
                )

              ],
            ),
          ),
          Expanded(
            child: ListView(
                          children: [
            _plateTileWidget(context, widget.people.copper),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.2),
              margin:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
            ),
            _plateTileWidget(context, widget.people.silver),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.2),
              margin:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
            ),
            _plateTileWidget(context, widget.people.gold),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.2),
              margin:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
            ),
            _plateTileWidget(context, widget.people.black),
            // Container(
            //   width: double.infinity,
            //   height: 1,
            //   color: Colors.black.withOpacity(0.2),
            //   margin:
            //       const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            // ),
            _sideDishListView(context)
                          ],
                        ),
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 16,top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MelonBouncingButton(
                        callback: () {
                          Navigator.of(context).pop();
                        },
                        borderRadius: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, bottom: 12, top: 12),
                          child: const Text(
                            "ยกเลิก",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Itim',
                                color: Colors.black),
                          ),
                        )),
                    MelonBouncingButton(
                        callback: () {
                          widget.callback?.call(widget.people);
                          Navigator.of(context).pop();
                        },
                        borderRadius: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, bottom: 12, top: 12),
                          child: const Text(
                            "บันทึก",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Itim',
                                color: Colors.black),
                          ),
                        )),
                  ]))
        ],
      ),
    );
  }

  Widget _sideDishListView(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      padding: const EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 30),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 26, right: 26, top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "เมนูอื่น ๆ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Itim',
                      color: Colors.black),
                ),
                MelonBouncingButton.text(
                    enabledHover: true,
                    text: "เพิ่มจาน",
                    fontFamily: "Itim",
                    textColor: Colors.white,
                    fontSize: 16,
                    height: 34,
                    x: -2,
                    borderRadius: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: Colors.black.withOpacity(0.8),
                    callback: () {
                      SushiroMainPage.showSmallDialog(
                        context,
                        pageHeight: size.resolve(context).height < 300 ? 0.8 : 0.45,
                        (BuildContext modalSheetContext, TextTheme textTheme) =>
                            addSideDishPage(
                          modalSheetContext,
                          textTheme,
                          pageHeight: size.resolve(context).height < 300 ? 0.8 : 0.45,
                          callback: (int? index,
                              SideDishPlateModel newSideDishPlate) {
                            widget.people.plates.add(newSideDishPlate);
                            setState(() {});
                          },
                        ),
                      );
                    })
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ...widget.people.plates
              .mapIndexed((index, plate) =>
                  _cardPlateTileWidget(context, plate, index: index))

        ],
      ),
    );
  }

  Widget _plateTileWidget(BuildContext context, PlateModel plate,
      {int? index}) {
    return Container(
      padding: const EdgeInsets.only(left: 26, right: 26, top: 16, bottom: 16),
      child: Row(
        children: [
          if (plate is SushiPlateModel) getSushiPlateWidget(plate.type),
          if (plate is SushiPlateModel)
            const SizedBox(
              width: 16,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plate is SushiPlateModel
                    ? getSushiPlateName(plate.type)
                    : (plate is SideDishPlateModel
                        ? plate.name ?? "ไม่ทราบ"
                        : "ไม่ทราบ"),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Itim',
                    color: Colors.black),
              ),
              Text(
                plate is SushiPlateModel
                    ? "${SushiroMainProvider.getSushiPlatePrice(plate.type)}"
                    : "${plate is SideDishPlateModel ? plate.price : "-"} บาท x ${plate.value} จาน",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Itim',
                    color: Colors.black.withOpacity(0.7)),
              )
            ],
          ),
          Expanded(child: Container()),
          if (plate is SushiPlateModel)
            Row(
              children: [
                MelonBouncingButton(
                    callback: () {
                      if (plate.value > 0) {
                        plate.value -= 1;
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        CupertinoIcons.minus,
                        size: 22,
                      ),
                    )).hover(y: -1, x: -0.5),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  plate.value.toString(),
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
                    callback: () {
                      plate.value += 1;
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        CupertinoIcons.add,
                        size: 24,
                      ),
                    )).hover(y: -1, x: -0.5)
              ],
            ),
          if (plate is SideDishPlateModel)
            Row(children: [
              MelonBouncingButton(
                  callback: () {
                    if (index != null) {
                      widget.people.plates.removeAt(index);
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 38,
                    width: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      CupertinoIcons.trash,
                      size: 22,
                    ),
                  )).hover(y: -1, x: -0.5),
              const SizedBox(
                width: 20,
              ),
              MelonBouncingButton(
                  callback: () {
                    SushiroMainPage.showSmallDialog(
                      context,
                      pageHeight: 0.45,
                      (BuildContext modalSheetContext, TextTheme textTheme) =>
                          addSideDishPage(
                        modalSheetContext,
                        textTheme,
                        pageHeight: 0.45,
                        plate: plate,
                        index: index,
                        callback:
                            (int? index, SideDishPlateModel newSideDishPlate) {
                          if (index != null) {
                            widget.people.plates[index] = newSideDishPlate;
                            setState(() {});
                          }
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      CupertinoIcons.pencil,
                      size: 24,
                    ),
                  )).hover(y: -1, x: -0.5)
            ])
        ],
      ),
    );
  }

  Widget _cardPlateTileWidget(BuildContext context, PlateModel plate,
      {int? index}) {
    return Container(
      margin: const EdgeInsets.only(left: 26, right: 26, top: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          if (plate is SushiPlateModel) getSushiPlateWidget(plate.type),
          if (plate is SushiPlateModel)
            const SizedBox(
              width: 16,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plate is SushiPlateModel
                    ? getSushiPlateName(plate.type)
                    : (plate is SideDishPlateModel
                        ? plate.name ?? "ไม่ทราบ"
                        : "ไม่ทราบ"),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Itim',
                    color: Colors.black),
              ),
              Text(
                plate is SushiPlateModel
                    ? "${SushiroMainProvider.getSushiPlatePrice(plate.type)}"
                    : "${plate is SideDishPlateModel ? plate.price : "-"} บาท x ${plate.value} จาน",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Itim',
                    color: Colors.black.withOpacity(0.7)),
              )
            ],
          ),
          Expanded(child: Container()),
          if (plate is SushiPlateModel)
            Row(
              children: [
                MelonBouncingButton(
                    callback: () {
                      if (plate.value > 0) {
                        plate.value -= 1;
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        CupertinoIcons.minus,
                        size: 22,
                      ),
                    )).hover(y: -1, x: -0.5),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  plate.value.toString(),
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
                    callback: () {
                      plate.value += 1;
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        CupertinoIcons.add,
                        size: 24,
                      ),
                    )).hover(y: -1, x: -0.5)
              ],
            ),
          if (plate is SideDishPlateModel)
            Row(children: [
              MelonBouncingButton(
                  callback: () {
                    if (index != null) {
                      widget.people.plates.removeAt(index);
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 38,
                    width: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      CupertinoIcons.trash,
                      size: 22,
                    ),
                  )).hover(y: -1, x: -0.5),
              const SizedBox(
                width: 20,
              ),
              MelonBouncingButton(
                  callback: () {
                    SushiroMainPage.showSmallDialog(
                      context,
                      pageHeight: 0.45,
                      (BuildContext modalSheetContext, TextTheme textTheme) =>
                          addSideDishPage(
                        modalSheetContext,
                        textTheme,
                        pageHeight: 0.45,
                        plate: plate,
                        index: index,
                        callback:
                            (int? index, SideDishPlateModel newSideDishPlate) {
                          if (index != null) {
                            widget.people.plates[index] = newSideDishPlate;
                            setState(() {});
                          }
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      CupertinoIcons.pencil,
                      size: 24,
                    ),
                  )).hover(y: -1, x: -0.5)
            ])
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
      return "จานทอง";
    } else if (type == SushiPlateType.black) {
      return "จานดำ";
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
}

WoltModalSheetPage peoplePage(
    BuildContext modalSheetContext, TextTheme textTheme, PeopleModel people,
    {Function(PeopleModel)? callback,VoidCallback? onChangeNameTapped,VoidCallback? onDeleteTapped}) {
  return WoltModalSheetPage(
      hasSabGradient: false,
      forceMaxHeight: false,
      navBarHeight: 0,
      backgroundColor: Colors.white,
      isTopBarLayerAlwaysVisible: false,
      child: PeoplePageDialog(
        people: people,
        callback: callback,
        onChangeNameTapped: onChangeNameTapped,
        onDeleteTapped: onDeleteTapped,
      ));
}
