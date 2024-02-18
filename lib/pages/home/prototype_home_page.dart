import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/components/me/melon_scaffold_widget.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';

import '../../core/components/me/card_widget.dart';

class PrototypeHomePage extends StatefulWidget {
  const PrototypeHomePage({Key? key}) : super(key: key);

  @override
  _PrototypeHomePageState createState() => _PrototypeHomePageState();
}

class _PrototypeHomePageState extends State<PrototypeHomePage> {
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
      body: realCardWidth.resolve(context) < 1036
          ? _smallLayout(context)
          : _largeLayout(context),
      children: [_background(context)],
      // overlayBody: MediaQuery.of(context).size.width > 800
      //     ? (Widget body) => Container(
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.centerLeft,
      //             end: Alignment.centerRight,
      //             colors: [
      //               // if(MediaQuery.of(context).size.width > 850)
      //               //   Colors.black.withOpacity(0.85),
      //
      //               // Colors.black.withOpacity(0.65),
      //               // Colors.black.withOpacity(0.50),
      //               Colors.black.withOpacity(0.20),
      //               Colors.black.withOpacity(0.1),
      //               Colors.black.withOpacity(0.0),
      //                 Colors.black.withOpacity(0.0),
      //               Colors.black.withOpacity(0.0),
      //
      //             ],
      //           ),
      //         ),
      //         child: body)
      //     : null,
    );
  }

  Widget _smallLayout(BuildContext context) {
    return Container();
  }

  Widget _largeLayout(BuildContext context) {
    double extraWidth = MediaQuery.of(context).size.width > 1100
        ? (MediaQuery.of(context).size.width - 1100) / 1.25
        : 0;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20 + extraWidth),
      width: MediaQuery.of(context).size.width - 550,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: cardWidth.resolve(context),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 60, bottom: 60),
                //padding:EdgeInsets.only(left: 20,top: 20,right: 20),
                children: [
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
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _background(BuildContext context) {
    String image = MediaQuery.of(context).size.width > 550
        ? "assets/images/melon_pool_land.webp"
        : "assets/images/melon_pool_port.webp";

    print(MediaQuery.of(context).size.width);

    Widget bgWidget = Container(
      color: const Color(0xffffffff),
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
      ),
    );

    return Stack(
      children: [
        bgWidget,
        // if (MediaQuery.of(context).size.width > 800)
        //   ImageFiltered(
        //     imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        //     child: ShaderMask(
        //       shaderCallback: (Rect rect) {
        //         return LinearGradient(
        //             begin: Alignment.centerLeft,
        //             end: Alignment.centerRight,
        //             colors: [
        //               Colors.black.withOpacity(0.0),
        //               Colors.black.withOpacity(0.15),
        //               //Colors.black.withOpacity(0.2),
        //
        //               Colors.black.withOpacity(0.5),
        //               //Colors.black.withOpacity(0.8),
        //               Colors.black,
        //
        //               Colors.black,
        //               Colors.black,
        //             ],
        //             ).createShader(rect);
        //       },
        //       blendMode: BlendMode.dstOut,
        //       child: bgWidget,
        //     ),
        //   )
      ],
    );
    return Container(
      color: const Color(0xffc54646),
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
      ),
    );
  }
}
