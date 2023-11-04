import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/components/me/card_widget.dart';
import 'package:melonkemo/core/components/segments/tab_segment_widget.dart';
import 'package:melonkemo/core/extensions/bot_toast_extension.dart';
import 'package:melonkemo/core/extensions/color_extension.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';

import 'package:melonkemo/core/components/cupertino_card/cupertino_rounded_corners.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MeProfilePage extends StatefulWidget {
  const MeProfilePage({Key? key}) : super(key: key);

  @override
  _MeProfilePageState createState() => _MeProfilePageState();
}

class _MeProfilePageState extends State<MeProfilePage> {
  PageController controller = PageController();

  AboutLanguage _aboutLanguage = AboutLanguage.thai;

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
    return layout.width <= 420 ? layout.width : 420;
  });

  final LayoutValue<double> realCardWidth = LayoutValue.builder((layout) {
    return layout.width;
  });

  List<SegmentItem> _tabItems(BuildContext context) =>
      [SegmentItem("บัญชี"), SegmentItem("คลังภาพ")];

  List<Widget> _accounts(BuildContext context) {
    return [
      _linkCard("Twitter", "https://twitter.com/melonkemo",
          icon: SimpleIcons.twitter),
      _linkCard("Facebook", "https://www.facebook.com/melonkemo",
          icon: SimpleIcons.facebook),
      _linkCard("Telegram", "https://t.me/melonkemo",
          icon: SimpleIcons.telegram),
      _linkCard("Mastadon", "https://kemonodon.club/@melonkemo",
          icon: SimpleIcons.mastodon),
      _linkCard("Bluesky", "https://bsky.app/profile/melonkemo.bsky.social",
          icon: SimpleIcons.icloud),
    ];
  }

  List<Widget> _menus(BuildContext context) => [
        _profileWidget(context, betweenBottom: 12),
        CardWidget(
            betweenBottom: 0,
            title: "แนะนำตัว",
            leadingTitle: _langSegment(context),
            width: cardWidth,
            children: _about(context)),
        const SizedBox(
          height: 6,
        ),
        _divider(context),
        const SizedBox(
          height: 26,
        ),
        //_segment(context),
        // const SizedBox(
        //   height: 16,
        // ),
        CardWidget(
          title: "บัญชีโซเชียล",
          children: _accounts(context),
          width: cardWidth,
        )
      ];

  List<Widget> _smallMenus(BuildContext context) => [
        //_segment(context),
        const SizedBox(
          height: 16,
        ),
        CardWidget(
            width: cardWidth,
            title: "บัญชีโซเชียล",
            children: _accounts(context))
      ];

  List<Widget> _largeMenus(BuildContext context) => [
        _profileWidget(context, betweenBottom: 12),
        CardWidget(
            width: cardWidth,
            betweenBottom: 0,
            title: "แนะนำตัว",
            children: _about(context),
            leadingTitle: _langSegment(context)),
      ];

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
        child: Stack(
          children: [
            _background(context),
            _imageCredit(context),
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.60),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     topColor,
                  //     bottomColor,
                  //   ],
                  // ),
                  //color: Colors.black,
                ),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    systemNavigationBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarIconBrightness: Brightness.dark,
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
                                    color:
                                        topColor.darken(.24).withOpacity(0.5),
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
                              padding:
                                  const EdgeInsets.only(left: 14, right: 12),
                              height: 46,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      //color: bottomColor.withOpacity(0.47)
                                      //color: bottomColor
                                      color: Colors.black.withOpacity(0.8))
                                ],
                              ),
                            ),
                          ],
                        )),
                    backgroundColor: Colors.transparent,
                    // body: DefaultTabController(
                    //   length: _tabItems(context).length,
                    //   child: realCardWidth.resolve(context) < 880
                    //       ? _smallLayout(context)
                    //       : _largeLayout(context),
                    // ),
                    body: realCardWidth.resolve(context) < 880
                        ? _smallLayout(context)
                        : _largeLayout(context),
                  ),
                )),
          ],
        ));
  }

  Widget _background(BuildContext context) {
    //String image = "assets/images/orange_brick_background.webp";
    String image = "assets/images/bangkok_background_image_medium.webp";

    return Container(
      color: const Color(0xFF46a1c5),
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(image, fit: BoxFit.cover),
    );
    return Container();
  }

  Widget _imageCredit(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Picture from Alejandro Cartagena on Unsplash.com",
            style: TextStyle(
                fontFamily: "Itim",
                color: Colors.white.withOpacity(0.75),
                fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _pageView(BuildContext context, List<Widget> children) {
    return Container(
      width: cardWidth.resolve(context),
      height: 100,
      child: PageView(
        controller: controller,
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  Widget _langSegment(BuildContext context) {
    List<SegmentItem> langItems = [
      SegmentItem<AboutLanguage>("ไทย", value: AboutLanguage.thai),
      SegmentItem<AboutLanguage>("English", value: AboutLanguage.english),
      SegmentItem<AboutLanguage>("日本語",
          value: AboutLanguage.japanese,
          config: SegmentConfigItem(fontSize: 12)),
    ];
    return DefaultTabController(
      length: langItems.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);

        return SizedBox(
          height: 30,
          width: 200,
          child: TabSegmentWidget(
            height: 20,
            controller: tabController,
            isScrollable: true,
            backgroundColor: Colors.black.withOpacity(0.05),
            itemFontSize: 14,
            minWidth: 20,
            items: langItems,
            onChanged: (int index) {
              _aboutLanguage = langItems[index].value;
              setState(() {});
              // controller.animateToPage(index,
              //     duration: const Duration(milliseconds: 200),
              //     curve: Curves.linear);
            },
          ),
        );
      }),
    );
  }

  Widget _largeLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 420,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _largeMenus(context),
            ).animate().fadeIn(delay: const Duration(milliseconds: 300)).move(
                delay: const Duration(milliseconds: 300),
                begin: const Offset(0, 100),
                end: const Offset(0, 0)),
          ),
        ),
        SizedBox(
          width: 420,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 80),
            child: SizedBox(
              width: context.layout.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _smallMenus(context),
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 300)).move(
                delay: const Duration(milliseconds: 300),
                begin: const Offset(0, 100),
                end: const Offset(0, 0)),
          ),
        )
      ],
    );
  }

  Widget _smallLayout(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
          left: 16, right: 16, top: kIsWeb ? 40 : 20, bottom: 80),
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
    );
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
            padding: const EdgeInsets.only(left: 16),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'メロン',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 40,
                      letterSpacing: 0.0,
                      fontFamily: 'MPlus',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 0),
                Text(
                  'Melon | เมล่อน',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 20,
                      letterSpacing: 0.0,
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  '26 • Male (Pan) • INFJ • Thai & English • Software Engineer',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
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

  Widget _linkCard(String serviceName, String link,
      {Color? serviceTextColor, double betweenBottom = 10, IconData? icon}) {
    return MelonBouncingButton(
        callback: () {
          Future.delayed(const Duration(milliseconds: 300)).then((value) {
            _launchUrl(link);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.35),
            borderRadius: BorderRadius.circular(12),
          ),
          width: cardWidth.resolve(context),
          constraints: const BoxConstraints(minHeight: 40),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: betweenBottom),
          padding:
              const EdgeInsets.only(left: 22, right: 22, bottom: 18, top: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                serviceName,
                style: TextStyle(
                    color: (serviceTextColor ?? Colors.black).withOpacity(0.70),
                    fontSize: 17,
                    letterSpacing: 0.0,
                    fontFamily: 'VarelaRound',
                    fontWeight: FontWeight.bold),
              ),
              if (icon != null)
                Icon(
                  icon,
                  size: 24,
                  color: (serviceTextColor ?? Colors.black).withOpacity(0.70),
                ),
            ],
          ),
        )).hover(x: -10.0, z: 1.05);
  }

  List<Widget> _about(BuildContext context) {
    return [
      if (_aboutLanguage == AboutLanguage.thai)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'สวัสดีครับ! ผมชื่อ “เมล่อน” เรียกสั้นๆ “เม” เป็นเผ่าจิ้งจอกอาร์กติก ชื่นชอบการเขียนโค้ด หลงไหลในเฟอร์รี่และเฟอร์สูท หวังว่าจะได้พบทุกคนในอีเว้นท์เร็ว ๆ นี้ ฝากตัวด้วยนะครับ!',
            style: TextStyle(
                color: Colors.black.withOpacity(0.75),
                fontSize: 17,
                letterSpacing: 0.0,
                fontFamily: 'Itim',
                height: 1.4,
                fontWeight: FontWeight.normal),
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 100)),
      if (_aboutLanguage == AboutLanguage.thai) const SizedBox(height: 16),
      if (_aboutLanguage == AboutLanguage.english)
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Hello everyone! My name is “Melon” and I’m arctic fox species, love coding and am passionate about furries and fursuits, Hope to meet everyone at the event soon See ya!',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.75),
                  fontSize: 17,
                  letterSpacing: 0.0,
                  height: 1.4,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.normal),
            )).animate().fadeIn(delay: const Duration(milliseconds: 100)),
      if (_aboutLanguage == AboutLanguage.english) const SizedBox(height: 16),
      if (_aboutLanguage == AboutLanguage.japanese)
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'こんばんは！はじめまして、僕は「メロン」と申します。北極ギツネです！僕の趣味はコーディングです！そして僕はファーリーとファースーツ憧れています。イベントで皆さんにお会いできるのを楽しみにしています！よろしくお願いいたします！',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.75),
                  fontSize: 14,
                  height: 1.5,
                  letterSpacing: 0.0,
                  fontFamily: 'KosugiMaru',
                  fontWeight: FontWeight.normal),
            )).animate().fadeIn(delay: const Duration(milliseconds: 100)),
      if (_aboutLanguage == AboutLanguage.japanese) const SizedBox(height: 16),
    ];
  }

  Widget _divider(BuildContext context) {
    return Container(
      width: cardWidth.resolve(context),
      height: 1.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white.withOpacity(.0),
            Colors.white.withOpacity(.38),
            Colors.white.withOpacity(.38),
            Colors.white.withOpacity(.38),
            Colors.white.withOpacity(.0),
          ],
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 80),
    );
  }
}

enum AboutLanguage { thai, english, japanese }
