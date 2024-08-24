import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/components/custom_sheet_type/melon_bottom_sheet_type.dart';
import 'package:melonkemo/components/custom_sheet_type/melon_dialog_type.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/infrastructure/under_construction_page.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

typedef OverlayWidget = Widget Function(Widget body);
typedef CustomAppbarBody = Widget Function(double height, Widget body);

class MelonScaffoldWidget extends StatelessWidget {
  const MelonScaffoldWidget(
      {super.key,
      this.children,
      this.overlayBody,
      required this.body,
      this.extendBodyBehindAppBar = false,
      this.backgroundColor,
      this.customAppbarBody,
      this.appBarColor,
      this.appBarNameTitleColor,
      this.appBarSubTitleColor,
      this.buttonText,
      this.onButtonClick,
      this.fontWeight = FontWeight.normal,
      this.height = 34.0,
      this.appBarName,
      this.appBarSubTitle,
      this.bottomSheet});

  final List<Widget>? children;
  final OverlayWidget? overlayBody;
  final CustomAppbarBody? customAppbarBody;
  final Color? backgroundColor;

  final Widget body;
  final bool extendBodyBehindAppBar;
  final Color? appBarColor;
  final Color? appBarNameTitleColor;
  final Color? appBarSubTitleColor;

  final String? buttonText;
  final VoidCallback? onButtonClick;
  final Widget? bottomSheet;
  final double height;
  final FontWeight fontWeight;
  final String? appBarName;
  final String? appBarSubTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if(backgroundColor != null)
          Container(color: backgroundColor),
        ...?children,
        overlayBody != null
            ? overlayBody!.call(_area(context))
            : _area(context),
      ],
    );
    // return Title(
    //   color: Colors.white,
    //   title: "メロンけも",
    //   child: Stack(
    //     children: [
    //       ...?children,
    //       overlayBody != null
    //           ? overlayBody!.call(_area(context))
    //           : _area(context),
    //     ],
    //   ),
    // );
  }

  Widget _area(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appbar(context),
          backgroundColor: Colors.transparent,
          //backgroundColor: backgroundColor ?? Colors.transparent,
          body: body,
          bottomSheet: bottomSheet,
        ),
      );

  PreferredSizeWidget appbar(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(appBarSubTitle != null ? 56 : 46),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            customAppbarBody != null
                ? customAppbarBody!.call(46.0, _appbarBody(context))
                : _appbarBody(context),
          ],
        ),
      );

  Widget _appbarBody(BuildContext context) {
    return Container(

      height: appBarSubTitle != null ? 56 : 46,
      decoration: BoxDecoration(color: appBarColor ?? Colors.white),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 14, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MelonBouncingButton(
            callback: () {
              context.go("/");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appBarName ?? "メロンけも",
                  style: TextStyle(
                      color:
                          appBarNameTitleColor ?? Colors.black.withOpacity(0.8),
                      fontSize: 22,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MPlus'),
                ),
                if (appBarSubTitle != null)
                  Text(
                    appBarSubTitle!,
                    style: TextStyle(
                        color: (appBarSubTitleColor ?? appBarNameTitleColor) ??
                            Colors.black.withOpacity(0.8),
                        fontSize: 10,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MPlus'),
                  ),
              ],
            ),
          ).hover(x: -2),
          MelonBouncingButton.text(
              enabledHover: true,
              text: buttonText ?? "ลงชื่อเข้าใช้",
              fontFamily: "Itim",
              textColor: Colors.white,
              fontSize: 16,
              height: height,
              fontWeight: fontWeight,
              x: -2,
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.black.withOpacity(0.8),
              callback: onButtonClick ??
                  () {
                    showDialog(context);
                  })
        ],
      ),
    );
  }

  void showDialog(BuildContext context) {
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
          //return WoltModalType.bottomSheet();
          return MelonBottomSheetType(
            constraint: (Size size){
              return BoxConstraints(
                maxWidth: size.width > (880 + 60) ? 880 : (size.width > 500 ? size.width - 60 : size.width),
                minWidth: size.width <= 520 ? size.width : 520,
                minHeight: size.width < 560 ? size.height * 0.9 : size.height * 0.85,
                maxHeight: size.height,
              );
            }
          );
        } else {
          return MelonDialogType(constraint: (Size size){
            return BoxConstraints(
              maxWidth: size.width > 880 ? 880 - 60 : (size.width > 560 ? size.width - 60 : size.width),
              minWidth: size.width > 880 ? 880 - 60 : (size.width > 560 ? size.width - 60 : size.width),
              minHeight: size.width < 560 ? size.height * 0.9 : size.height * 0.85,
              maxHeight: size.height,
            );
          });
        }
      },
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
      },

    );
  }

  WoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme) {
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
          height: size.resolve(modalSheetContext).width < 560
              ? size.resolve(modalSheetContext).height * 0.90
              : size.resolve(modalSheetContext).height * 0.85,
          child: const UnderConstructionPage(
            enabledAppbar: false,
          )),
    );
  }
}