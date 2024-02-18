import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/infrastructure/under_construction_page.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

typedef OverlayWidget = Widget Function(Widget body);

class MelonScaffoldWidget extends StatelessWidget {
  const MelonScaffoldWidget(
      {super.key, this.children, this.overlayBody, required this.body});

  final List<Widget>? children;
  final OverlayWidget? overlayBody;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.white,
      title: "メロンけも",
      child: Stack(
        children: [
          ...?children,
          overlayBody != null
              ? overlayBody!.call(_area(context))
              : _area(context),
        ],
      ),
    );
  }

  Widget _area(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: appbar(context),
          backgroundColor: Colors.transparent,
          body: body,
        ),
      );

  PreferredSizeWidget appbar(BuildContext context) => PreferredSize(
        preferredSize: const Size.fromHeight(46.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 14, right: 12),
              height: 46,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "メロンけも",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 22,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MPlus'),
                  ).hover(x: -2),
                  MelonBouncingButton.text(
                    enabledHover: true,
                    text: "ลงชื่อเข้าใช้",
                    fontFamily: "Itim",
                    textColor: Colors.white,
                    fontSize: 16,
                    height: 34,
                    x: -2,
                    borderRadius: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: Colors.black.withOpacity(0.8),
                    callback: (){
                      showDialog(context);
                    }
                  )
                ],
              ),
            ),
          ],
        ),
      );

  void showDialog(BuildContext context){
    final LayoutValue<double> width = LayoutValue.builder((layout) {
      return layout.width;
    });

    WoltModalSheet.show<void>(
      //pageIndexNotifier: pageIndexNotifier,
      barrierDismissible: true,
      showDragHandle: false,
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          page1(modalSheetContext, textTheme),
        ];
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
      minDialogWidth: 520,
      minPageHeight: width.resolve(context) < 560 ? 0.9 : 0.85,
      maxPageHeight: 1.0,
    );
  }

  WoltModalSheetPage page1(BuildContext modalSheetContext, TextTheme textTheme) {
    final LayoutValue<Size> size = LayoutValue.builder((layout) {
      return Size(layout.width, layout.size.height);
    });

    return WoltModalSheetPage(
      hasSabGradient: false,
      forceMaxHeight: false,
      navBarHeight: 0,
      backgroundColor: const Color(0xFFFFB920),
      // stickyActionBar: const Padding(
      //   padding: EdgeInsets.all(0),
      //   child: Column(
      //     children: [
      //       // ElevatedButton(
      //       //   onPressed: () => Navigator.of(modalSheetContext).pop(),
      //       //   child: const SizedBox(
      //       //     height: 50,
      //       //     width: double.infinity,
      //       //     child: Center(child: Text('Cancel')),
      //       //   ),
      //       // ),
      //       // const SizedBox(height: 8),
      //       // ElevatedButton(
      //       //   onPressed: () => pageIndexNotifier.value = pageIndexNotifier.value + 1,
      //       //   child: const SizedBox(
      //       //     height: _buttonHeight,
      //       //     width: double.infinity,
      //       //     child: Center(child: Text('Next page')),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      //topBarTitle: Text('Pagination', style: textTheme.titleSmall),
      isTopBarLayerAlwaysVisible: false,
      // trailingNavBarWidget: IconButton(
      //   padding: const EdgeInsets.all(20),
      //   icon: const Icon(Icons.close),
      //   onPressed: Navigator.of(modalSheetContext).pop,
      // ),
      child: Container(
          color: Colors.black,
          height: size.resolve(modalSheetContext).width < 560 ? size.resolve(modalSheetContext).height * 0.90:size.resolve(modalSheetContext).height * 0.85,
          child: const UnderConstructionPage(enabledAppbar: false,)
      ),
    );
  }
}
