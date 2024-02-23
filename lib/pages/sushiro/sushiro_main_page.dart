import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/components/me/melon_scaffold_widget.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/infrastructure/under_construction_page.dart';
import 'package:melonkemo/pages/sushiro/dialogs/add_people_dialog.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_provider.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'dialogs/people_page_dialog.dart';
import 'dialogs/summary_page_dialog.dart';

typedef WoltPageLayoutCallback = WoltModalSheetPage Function(
    BuildContext context, TextTheme textTheme);

class SushiroMainPage extends StatefulWidget {
  const SushiroMainPage({Key? key}) : super(key: key);

  @override
  _SushiroMainPageState createState() => _SushiroMainPageState();
}

class _SushiroMainPageState extends State<SushiroMainPage> {
  late final SushiroMainProvider _provider;

  double tableWidth = 30;
  double bottomSheetHeight = 100;

  final LayoutValue<double> areaWidth = LayoutValue.builder((layout) {
    return layout.width <= 500 ? layout.width : 500;
  });

  @override
  void initState() {
    _provider = SushiroMainProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return ChangeNotifierProvider(
      create: (_) => _provider,
      builder: (BuildContext ct, Widget? widget) {
        return MelonScaffoldWidget(
          //backgroundColor: Colors.white,
          body: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: areaWidth.resolve(context),
                child: _listView(ct),
              )
            ],
          ),
          buttonText: "เพิ่มคน",
          onButtonClick: () {
            showSmallDialog(
                context,
                pageHeight: 0.3,
                (BuildContext modalSheetContext, TextTheme textTheme) =>
                    addPeople(modalSheetContext, textTheme, pageHeight: 0.3));
          },
          bottomSheet: Container(
            color: Colors.white,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [bottomSheet(ct)]),
          ),
        );
      },
    );
  }

  Widget bottomSheet(BuildContext context) {
    return MelonBouncingButton(
      callback: () {
        showDialog(
            context,
            (BuildContext modalSheetContext, TextTheme textTheme) =>
                summaryPage(modalSheetContext, textTheme));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: areaWidth.resolve(context),
        height: bottomSheetHeight,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 17),
              child: Text(
                "ราคารวม",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Itim',
                ),
              ),
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Text(
                  "${context.read<SushiroMainProvider>().calculatePrice(includeServiceCharge: true).toStringAsFixed(2)} บาท",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                    fontFamily: 'Itim',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 56),
                  child: Text(
                    "ราคาก่อนเซอร์วิส:  ${context.read<SushiroMainProvider>().calculatePrice().toStringAsFixed(2)} บาท",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Itim',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _listView(BuildContext context) {
    List<PeopleModel> peoples = context.watch<SushiroMainProvider>().peoples;

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          itemCount: peoples.length,
          padding: EdgeInsets.only(bottom: bottomSheetHeight + 50),
          separatorBuilder: (BuildContext context, int index) => Container(
            width: 1,
            height: 1,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 6),
          ),
          itemBuilder: (BuildContext context, int index) {
            return _peopleListItem(context,
                people: peoples[index],
                plates: context
                    .read<SushiroMainProvider>()
                    .getPlateFromPeopleId(peoples[index].id));
          },
        ));
  }

  Widget _peopleListItem(BuildContext context,
      {required PeopleModel people, required List<PlateModel> plates}) {
    List<SideDishPlateModel> sideDishPlates =
        plates.whereType<SideDishPlateModel>().toList();
    Map<SushiPlateType, List<SushiPlateModel>> groupSushiPlates = groupBy(
        plates.whereType<SushiPlateModel>().toList(),
        (SushiPlateModel sushiPlate) => sushiPlate.type);

    return MelonBouncingButton(
      callback: () {
        showDialog(
            context,
            (BuildContext modalSheetContext, TextTheme textTheme) =>
                peoplePage(modalSheetContext, textTheme, people));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 17),
                    child: Text(
                      people.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Itim',
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Text(
                        "${context.read<SushiroMainProvider>().calculatePrice(peopleId: people.id, includeServiceCharge: true).toStringAsFixed(2)} บาท",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                          fontFamily: 'Itim',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 42),
                        child: Text(
                          "ราคาก่อนเซอร์วิส:  ${context.read<SushiroMainProvider>().calculatePrice(
                                peopleId: people.id,
                              ).toStringAsFixed(2)} บาท",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Itim',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 100,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    children: [
                      getCounterPlateWidget(SushiPlateType.copper,
                          plates:
                              groupSushiPlates[SushiPlateType.copper] ?? []),
                      const SizedBox(width: 16),
                      getCounterPlateWidget(SushiPlateType.silver,
                          plates:
                              groupSushiPlates[SushiPlateType.silver] ?? []),
                      const SizedBox(width: 16),
                      getCounterPlateWidget(SushiPlateType.gold,
                          plates: groupSushiPlates[SushiPlateType.gold] ?? []),
                      const SizedBox(width: 16),
                      getCounterPlateWidget(SushiPlateType.black,
                          plates: groupSushiPlates[SushiPlateType.black] ?? []),
                      const SizedBox(width: 16),
                      getCounterPlateWidget(null, plates: sideDishPlates)
                    ]))
          ],
        ),
      ).hover(y: -5, x: -10),
    );
  }

  Widget getCounterPlateWidget(SushiPlateType? type,
      {required List<PlateModel> plates}) {
    double price = type != null
        ? SushiroMainProvider.calculateSushi(type, plates.length)
        : SushiroMainProvider.calculateSideDish(plates);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            getSushiPlateWidget(type),
            Text(
              "${plates.length}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Itim',
                  color: getSushiPlateTextColor(type)),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${price > 0 ? price : "-"}",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Itim',
              color: getSushiPlateBorderColor(type)),
        )
      ],
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

  Widget plateWidget(Color bodyColor,
      {double borderRadius = 100, Color? borderColor}) {
    return Container(
      decoration: BoxDecoration(
          border: borderColor != null
              ? Border.all(color: borderColor, width: 3)
              : null,
          color: bodyColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      width: 60,
      height: 60,
    );
  }

  void showDialog(BuildContext context, WoltPageLayoutCallback page) {
    final LayoutValue<double> width = LayoutValue.builder((layout) {
      return layout.width;
    });

    WoltModalSheet.show<void>(
      //pageIndexNotifier: pageIndexNotifier,
      barrierDismissible: true,
      showDragHandle: false,
      enableDrag: true,
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [page.call(context, textTheme)];
      },
      modalTypeBuilder: (context) {
        if (width.resolve(context) < 560) {
          return WoltModalType.bottomSheet;
        } else {
          return WoltModalType.dialog;
        }
      },
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
      },
      maxDialogWidth: 880,
      minDialogWidth: areaWidth.resolve(context),
      minPageHeight: width.resolve(context) < 560 ? 0.9 : 0.85,
      maxPageHeight: 1.0,
    );
  }

  void showSmallDialog(BuildContext context, WoltPageLayoutCallback page,
      {double pageHeight = 0.4}) {
    WoltModalSheet.show<void>(
      //pageIndexNotifier: pageIndexNotifier,
      barrierDismissible: true,
      showDragHandle: false,
      enableDrag: true,
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [page.call(context, textTheme)];
      },
      modalTypeBuilder: (context) {
        return WoltModalType.dialog;
      },
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
      },
      maxDialogWidth: 360,
      minDialogWidth: 360,
      minPageHeight: pageHeight,
      maxPageHeight: pageHeight,
    );
  }
}
