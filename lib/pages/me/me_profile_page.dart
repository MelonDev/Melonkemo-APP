import 'dart:js' as js;

import 'package:bot_toast/bot_toast.dart';
import 'package:demoji/demoji.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/bot_toast_extension.dart';
import 'package:melonkemo/core/extensions/color_extension.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';

import 'package:melonkemo/core/components/cupertino_card/cupertino_rounded_corners.dart';
import 'package:url_launcher/url_launcher.dart';

class MeProfilePage extends StatefulWidget {
  const MeProfilePage({Key? key}) : super(key: key);

  @override
  _MeProfilePageState createState() => _MeProfilePageState();
}

class _MeProfilePageState extends State<MeProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  //final Color topColor =  const Color(0xFFD3CCE3);
  //final Color bottomColor =  const Color(0xFFE9E4F0);
  final Color topColor = const Color(0xFF2BC0E4);
  final Color bottomColor = const Color(0xFFEAECC6);

  //final Color bottomColor = const Color(0xFF45B649);

  //final Color? buttonTextColor = Colors.white;
  final Color? buttonTextColor = null;

  final LayoutValue<double> cardWidth = LayoutValue.builder((layout) {
    return layout.width <= 400 ? layout.width : 400;
  });

  List<Widget> _accounts(BuildContext context) {
    return [
      const SizedBox(height:2),
      _linkCard("Twitter", "https://twitter.com/melonkemo"),
      _linkCard("Facebook", "https://www.facebook.com/melonkemo"),
      _linkCard("Telegram", "https://t.me/melonkemo"),
      _linkCard("Mastadon", "https://kemonodon.club/@melonkemo"),
      _linkCard("Bluesky", "https://bsky.app/profile/melonkemo.bsky.social"),
    ];
  }

  List<Widget> _menus(BuildContext context) {
    return [
      _profileWidget(context, betweenBottom: 12),
      _card(context,
          betweenBottom: 10, title: "แนะนำตัว", children: _about(context)),
      _card(context,
          betweenBottom: 10, title: "บัญชี", children: _accounts(context))
    ];
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
    } else {
      BotToast().component.error('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Title(
        color: Colors.white,
        title: "メロンけも",
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                topColor,
                bottomColor,
              ],
            ),
            //color: Colors.black,
          ),
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(46.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: context.layout.width,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            //spreadRadius: 3,
                            spreadRadius: 0.0,
                            color: topColor.darken(.24).withOpacity(0.5),
                            offset: const Offset(0, 0.0),
                            //blurRadius: 8.0,
                            blurRadius: 0.0)
                      ]),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          //color:Color(0xFFf1edf5)
                          color: Colors.white
                          //color: Colors.black
                          ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 14, right: 12),
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "メロンけも",
                            style: TextStyle(
                                //color: topColor.lighten(.24),
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 22,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                //fontFamily: 'KosugiMaru',
                                //fontFamily: 'MochiyPopOne',
                                fontFamily: 'MPlus'),
                          ).hover(x: -2),
                          MelonBouncingButton.text(
                              enabledHover: true,
                              text: "ลงชื่อเข้าใช้",
                              fontFamily: "Itim",
                              textColor: Colors.white,
                              // textColor:
                              //     buttonTextColor ?? bottomColor.darken(.74),
                              fontSize: 16,
                              height: 34,
                              x: -2,
                              borderRadius: 20,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              //color: bottomColor.withOpacity(0.47)
                              //color: bottomColor
                              color: Colors.black.withOpacity(0.8))
                        ],
                      ),
                    ),
                  ],
                )),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 50, bottom: 20),
              child: Container(
                width: context.layout.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _menus(context),
                ),
              ).animate().fadeIn(delay: const Duration(milliseconds: 300)).move(
                  delay: const Duration(milliseconds: 300),
                  begin: const Offset(0, 100),
                  end: const Offset(0, 0)),
            ),
          ),
        ));
  }

  Widget _profileWidget(BuildContext context, {double betweenBottom = 0}) {
    return Container(
      width: cardWidth.resolve(context),
      margin: EdgeInsets.only(bottom: betweenBottom),
      child: Row(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: CupertinoCard(
              elevation: 0,
              color: Colors.white.withOpacity(.48),
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(7),
              radius: BorderRadius.circular(80),
              child: CupertinoCard(
                elevation: 0,
                color: Colors.transparent,
                margin: const EdgeInsets.all(0),
                radius: BorderRadius.circular(66),
                child: Image.asset(
                  "assets/images/profile_29-oct-2023.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            height: 160,
            padding: const EdgeInsets.only(left:16),
            decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'メロン | Melon',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75),
                          fontSize: 16,
                          letterSpacing: 0.0,
                          fontFamily: 'Itim',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '26 • Male • INFJ • Pan ${Demoji.rainbow_flag} • Thai ${Demoji.thailand} & English ${Demoji.england} • Software Engineer •  Fan • I love coding and am passionate about furries and fursuits',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75),
                          fontSize: 16,
                          letterSpacing: 0.0,
                          fontFamilyFallback: const [ 'Itim','Apple Color Emoji', ],
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
          ))
        ],
      ),
    );
  }

  Widget _linkCard(String serviceName, String link,
      {Color? serviceTextColor, double betweenBottom = 10}) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        _launchUrl(link);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.45),
          borderRadius: BorderRadius.circular(10),
        ),
        width: cardWidth.resolve(context),
        constraints: const BoxConstraints(minHeight: 40),
        margin: EdgeInsets.only(left: 10, right: 10, bottom: betweenBottom),
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              serviceName,
              style: TextStyle(
                  color: (serviceTextColor ?? Colors.black).withOpacity(0.75),
                  fontSize: 18,
                  letterSpacing: 0.0,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.w600),
            ),
            // const SizedBox(height: 6),
            // Text(
            //   linkMessage,
            //   style: TextStyle(
            //       color: Colors.black.withOpacity(0.85),
            //       fontSize: 18,
            //       letterSpacing: 0.0,
            //       fontFamily: 'Itim',
            //       fontWeight: FontWeight.normal),
            // ),
          ],
        ),
      ).hover(x: -4.0, z: 1.02),
    );
  }

  Widget _card(BuildContext context,
      {required String title,
      double betweenBottom = 0,
      List<Widget>? children}) {
    return CupertinoCard(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white.withOpacity(.28),
      radius: BorderRadius.circular(40),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            //color: Colors.white.withOpacity(.28),
            borderRadius: BorderRadius.circular(10)),
        constraints: const BoxConstraints(minHeight: 100),
        width: cardWidth.resolve(context),
        margin: EdgeInsets.only(bottom: betweenBottom),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.15),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              width: cardWidth.resolve(context),
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.65),
                    fontSize: 20,
                    letterSpacing: 0.0,
                    fontFamily: 'Itim',
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (children != null) const SizedBox(height: 12),
            for (Widget widget in children ?? []) widget,
            if (children != null) const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  List<Widget> _about(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'สวัสดีครับ! ชื่อ “เมล่อน” เรียกสั้นๆ "เม" ก็ได้ หวังว่าจะได้พบทุกคนในอีเว้นท์เร็ว ๆ นี้ ฝากตัวด้วยนะครับ',
          style: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: 16,
              letterSpacing: 0.0,
              fontFamily: 'Itim',
              fontWeight: FontWeight.normal),
        ),
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Hello everyone! My name is Melon, Hope to meet everyone at the event soon See ya!',
          style: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: 16,
              letterSpacing: 0.0,
              fontFamily: 'Itim',
              fontWeight: FontWeight.normal),
        ),
      ),
    ];
  }
}
