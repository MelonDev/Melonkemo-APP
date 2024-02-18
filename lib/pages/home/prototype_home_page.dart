import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/components/me/card_widget.dart';
import 'package:melonkemo/core/components/me/melon_scaffold_widget.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:shimmer/shimmer.dart';

class PrototypeHomePage extends StatefulWidget {
  const PrototypeHomePage({Key? key}) : super(key: key);

  @override
  _PrototypeHomePageState createState() => _PrototypeHomePageState();
}

class _PrototypeHomePageState extends State<PrototypeHomePage> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  double blur = 0;

  @override
  void initState() {
    _controller.addListener(() {
      print("SIZE: ${_controller.size}");
      setState(() {
        blur = (_controller.size <= 0.25)
            ? 0.0
            : (_controller.size >= 0.55)
                ? 2.0
                : (_controller.size - 0.25) * (2.0 / 0.3);
      });
    });
    super.initState();
  }

  final LayoutValue<double> realCardWidth = LayoutValue.builder((layout) {
    return layout.width;
  });

  final LayoutValue<double> cardWidth = LayoutValue.builder((layout) {
    return layout.width <= 420 ? layout.width : 420;
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MelonScaffoldWidget(
      body: _layout(context),
      children: [_background(context)],
    );
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
    double topPadding = MediaQuery.of(context).size.height * 0.7;
    return _listCards(context,
        topPadding: topPadding,
        contentWidth: MediaQuery.of(context).size.width,
        mainAxisAlignment: MainAxisAlignment.center);
  }

  Widget _mediumLayout(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.7;
    return _listCards(context,
        topPadding: topPadding,
        contentWidth: MediaQuery.of(context).size.width,
        mainAxisAlignment: MainAxisAlignment.center);
  }

  Widget _largeLayout(BuildContext context) {
    print("width: ${MediaQuery.of(context).size.width}");
    double extraWidth = MediaQuery.of(context).size.width > 1050
        ? (MediaQuery.of(context).size.width - 1050) / 1.45
        : 0;
    print("extraWidth: $extraWidth, right: ${20 + extraWidth}");

    return _listCards(context, extraWidth: extraWidth);
  }

  Widget _listCards(BuildContext context,
      {double extraWidth = 0,
      double topPadding = 60,
      double? contentWidth,
      MainAxisAlignment? mainAxisAlignment}) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20 + extraWidth),
      width: contentWidth ?? MediaQuery.of(context).size.width - 550,
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
        children: [
          Container(
            width: cardWidth.resolve(context),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: DraggableScrollableSheet(
                controller: _controller,
                expand: false,
                initialChildSize: 1.0,
                minChildSize: 1.0,
                maxChildSize: 1.0,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return ListView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: topPadding, bottom: 60),
                    children: [
                      if (MediaQuery.of(context).size.width <= 1036)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Shimmer(
                              gradient: LinearGradient(colors: [
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(1.0)
                              ]),
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        CupertinoIcons.chevron_left_2,
                                        size: 18,
                                      )),
                                  SizedBox(width: 8),
                                  Text(
                                    'เลื่อนขึ้นเพื่อดูข้อมูล',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Itim',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                ],
                              ),
                            ),),
                      CardWidget(
                        cardTitleColor: Colors.white.withOpacity(.0),
                        cardColor: Colors.grey.withOpacity(.48),
                        titleColor: Colors.white.withOpacity(.9),
                        width: cardWidth,
                        sigma: 32,
                        betweenBottom: 0,
                        title: "ทดสอบ 1",
                        children: [Container(height: 100)],
                      ),
                      CardWidget(
                        cardTitleColor: Colors.white.withOpacity(.0),
                        cardColor: Colors.grey.withOpacity(.48),
                        titleColor: Colors.white.withOpacity(.9),
                        sigma: 32,
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
          )
        ],
      ),
    );
  }

  String _image(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1036) {
      return "assets/images/melon_pool_large.webp";
    } else if (MediaQuery.of(context).size.width > 600) {
      return "assets/images/melon_pool_medium.webp";
    } else {
      return "assets/images/melon_pool_small.webp";
    }
  }

  Widget _background(BuildContext context) {
    print(MediaQuery.of(context).size.width);

    return Container(
      color: const Color(0xffffffff),
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        _image(context),
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
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
}
