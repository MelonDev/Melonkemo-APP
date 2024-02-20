import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/state_manager.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/components/cupertino_card/cupertino_rounded_corners.dart';
import 'package:melonkemo/core/components/me/card_widget.dart';
import 'package:melonkemo/core/components/me/melon_scaffold_widget.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/home/prototype_home_provider.dart';
import 'package:provider/provider.dart';

class PrototypeHomePage extends StatefulWidget {
  const PrototypeHomePage({Key? key}) : super(key: key);

  @override
  _PrototypeHomePageState createState() => _PrototypeHomePageState();
}

class _PrototypeHomePageState extends State<PrototypeHomePage> {
  //late final DraggableScrollableController _controller ;
  late final PrototypeHomeProvider _provider;

  double blur = 0;

  final LayoutValue<double> realCardWidth = LayoutValue.builder((layout) {
    return layout.width;
  });

  final LayoutValue<double> cardWidth = LayoutValue.builder((layout) {
    return layout.width <= 420 ? layout.width : 420;
  });

  @override
  void initState() {
    _provider = PrototypeHomeProvider();
    // _controller =
    //     DraggableScrollableController();

    print("initState");
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (BuildContext ct, Widget? widget) {
          return MelonScaffoldWidget(
            body: _layout(ct)
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 300))
                .move(
                delay: const Duration(milliseconds: 500),
                begin: const Offset(0, 100),
                end: const Offset(0, 0)),
            children: [_background(ct)],
          );
        });

  }

  Widget _layout(BuildContext context) {
    if (realCardWidth.resolve(context) < 600) {
      return _smallLayout(context);
    } else if (realCardWidth.resolve(context) < 1036) {
      return _mediumLayout(context);
    } else {
      return _largeLayout(context);
    }
  }

  Widget _smallLayout(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.5;
    return _listCards(context,
        topPadding: topPadding,
        //contentWidth: cardWidth.resolve(context),
        contentWidth: realCardWidth.resolve(context),
        mainAxisAlignment: MainAxisAlignment.center);
  }

  Widget _mediumLayout(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.6;
    return _listCards(context,
        topPadding: topPadding,
        contentWidth: realCardWidth.resolve(context),
        mainAxisAlignment: MainAxisAlignment.center);
  }

  Widget _largeLayout(BuildContext context) {
    print("width: ${MediaQuery.of(context).size.width}");
    double extraWidth = realCardWidth.resolve(context) > 1050
        ? (realCardWidth.resolve(context) - 1050) / 1.45
        : 0;
    print("extraWidth: $extraWidth, right: ${20 + extraWidth}");

    return _listCards(context, extraWidth: extraWidth);
  }

  Widget _listCards(BuildContext context,
      {double extraWidth = 0,
      double topPadding = 60,
      double? contentWidth,
      MainAxisAlignment? mainAxisAlignment}) {
    Widget listContainer = Container(
      width: cardWidth.resolve(context),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: DraggableScrollableSheet(
          //controller: _controller,
          expand: false,
          initialChildSize: 1.0,
          minChildSize: 1.0,
          maxChildSize: 1.0,
          builder: (BuildContext context, ScrollController scrollController) {
            scrollController.addListener(() {
              if(realCardWidth.resolve(context) < 1036){
                _provider.setBlur(scrollController.offset);
              }else {
                _provider.setBlur(0.0);
              }
            });
            return ListView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: topPadding, bottom: 60),
              children: [
                // if (MediaQuery.of(context).size.width <= 1036)
                //   Padding(
                //       padding: const EdgeInsets.only(bottom: 10),
                //       child:  Row(
                //         mainAxisSize: MainAxisSize.max,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           RotatedBox(
                //               quarterTurns: 1,
                //               child: Icon(
                //                 CupertinoIcons.chevron_left_2,
                //                 size: 22,
                //                 color: Colors.white.withOpacity(0.7),
                //               )),
                //           const SizedBox(width: 8),
                //           Text(
                //             'เลื่อนขึ้นเพื่อดูข้อมูล',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 20.0,
                //               fontFamily: 'Itim',
                //               color: Colors.white.withOpacity(0.7),
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           SizedBox(width: 22),
                //         ],
                //       ),
                //       ),
                _profileWidget(context),
                CardWidget(
                  cardTitleColor: Colors.white.withOpacity(.0),
                  //cardColor: Colors.grey.withOpacity(.48),
                  cardColor: Colors.white.withOpacity(.65),
                  //titleColor: Colors.white.withOpacity(.9),
                  width: cardWidth,
                  sigma: 22,
                  betweenBottom: 0,
                  title: "ทดสอบ 1",
                  children: [Container(height: 100)],
                ),
                CardWidget(
                  cardTitleColor: Colors.white.withOpacity(.0),
                  cardColor: Color(0xFFCFCFCF).withOpacity(.38),
                  titleColor: Colors.white.withOpacity(.9),
                  sigma: 22,
                  width: cardWidth,
                  betweenBottom: 0,
                  title: "ทดสอบ 2",
                  children: [Container(height: 200)],
                ),
                CardWidget(
                  cardTitleColor: Colors.white.withOpacity(.0),
                  cardColor: Colors.grey.withOpacity(.48),
                  titleColor: Colors.white.withOpacity(.9),
                  width: cardWidth,
                  sigma: 32,
                  betweenBottom: 0,
                  title: "ทดสอบ 3",
                  children: [Container(height: 150)],
                ),
              ],
            );
          },
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: realCardWidth.resolve(context) <= 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20 + extraWidth),
          constraints: realCardWidth.resolve(context) <= 600 ? const BoxConstraints(maxWidth:420) : null,
          width: contentWidth ?? realCardWidth.resolve(context) - 550,
          child: realCardWidth.resolve(context) <= 600
              ? listContainer
              : Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
            children: [
              listContainer
            ],
          ),
        )
      ],
    );
  }

  String _image(BuildContext context) {
    if (realCardWidth.resolve(context) > 1036) {
      return "assets/images/melon_pool_large.webp";
    } else if (realCardWidth.resolve(context) > 600) {
      return "assets/images/melon_pool_medium.webp";
    } else {
      return "assets/images/melon_pool_small.webp";
    }
  }

  Widget _background(BuildContext context) {

    double sigma = context.watch<PrototypeHomeProvider>().blur;
    return Container(
      color: const Color(0xffffffff),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _image(context),
            fit: BoxFit.cover,
            alignment: realCardWidth.resolve(context) > 600 ? Alignment.centerRight : Alignment.center,
          ),
    BackdropFilter(
    filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),child: Container(),),
        ],
      ),
    );

    // return Stack(
    //   children: [
    //     bgWidget,
    //     // if (MediaQuery.of(context).size.width > 800)
    //     //   ImageFiltered(
    //     //     imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    //     //     child: ShaderMask(
    //     //       shaderCallback: (Rect rect) {
    //     //         return LinearGradient(
    //     //             begin: Alignment.centerLeft,
    //     //             end: Alignment.centerRight,
    //     //             colors: [
    //     //               Colors.black.withOpacity(0.0),
    //     //               Colors.black.withOpacity(0.15),
    //     //               //Colors.black.withOpacity(0.2),
    //     //
    //     //               Colors.black.withOpacity(0.5),
    //     //               //Colors.black.withOpacity(0.8),
    //     //               Colors.black,
    //     //
    //     //               Colors.black,
    //     //               Colors.black,
    //     //             ],
    //     //             ).createShader(rect);
    //     //       },
    //     //       blendMode: BlendMode.dstOut,
    //     //       child: bgWidget,
    //     //     ),
    //     //   )
    //   ],
    // );
  }

  Widget _profileWidget(BuildContext context, {double betweenBottom = 0}) {
    return Container(
      width: cardWidth.resolve(context),
      margin: EdgeInsets.only(bottom: betweenBottom),
      child: Row(
        children: [
          // Container(
          //   width: 160,
          //   height: 160,
          //   decoration: const BoxDecoration(color: Colors.transparent),
          //   child: CupertinoCard(
          //     elevation: 0,
          //     color: Colors.white.withOpacity(.48),
          //     margin: const EdgeInsets.all(0),
          //     padding: const EdgeInsets.all(7),
          //     radius: BorderRadius.circular(80),
          //     child: CupertinoCard(
          //       elevation: 0,
          //       color: Colors.transparent,
          //       margin: const EdgeInsets.all(0),
          //       radius: BorderRadius.circular(66),
          //       child: Image.asset(
          //         "assets/images/profile_29-oct-2023.webp",
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
              child: Container(
                height: 160,
                //padding: const EdgeInsets.only(left: 16),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'メロン',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.92),
                          fontSize: 40,
                          letterSpacing: 0.0,
                          fontFamily: 'MPlus',
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 0),
                    Text(
                      'Melon | เมล่อน',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 20,
                          letterSpacing: 0.0,
                          fontFamily: 'Itim',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '26 • Male (Pan) • INFJ • Thai & English • Software Engineer',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 16,
                          letterSpacing: 0.0,
                          fontFamily: 'Itim',
                          //fontFamilyFallback: const [ 'Itim','Apple Color Emoji', ],
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ))
        ],
      ),
    );
  }

}
