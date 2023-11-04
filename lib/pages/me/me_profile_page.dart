import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/me/card_list_widget.dart';
import 'package:melonkemo/core/components/me/card_widget.dart';
import 'package:melonkemo/core/components/me/melon_scaffold_widget.dart';
import 'package:melonkemo/core/components/segments/tab_segment_widget.dart';
import 'package:melonkemo/core/components/cupertino_card/cupertino_rounded_corners.dart';
import 'package:simple_icons/simple_icons.dart';

class MeProfilePage extends StatefulWidget {
  const MeProfilePage({super.key});

  @override
  State<MeProfilePage> createState() => _MeProfilePageState();
}

class _MeProfilePageState extends State<MeProfilePage> {
  PageController controller = PageController();
  AboutLanguage _aboutLanguage = AboutLanguage.thai;

  @override
  void initState() {
    super.initState();
  }

  final Color topColor = const Color(0xFF2BC0E4);
  final Color bottomColor = const Color(0xFFEAECC6);
  final Color? buttonTextColor = null;

  final LayoutValue<double> cardWidth = LayoutValue.builder((layout) {
    return layout.width <= 420 ? layout.width : 420;
  });

  final LayoutValue<double> realCardWidth = LayoutValue.builder((layout) {
    return layout.width;
  });

  List<Widget> _accounts(BuildContext context) {
    return [
      CardListWidget("Twitter", "https://twitter.com/melonkemo",
          icon: SimpleIcons.twitter, width: cardWidth),
      CardListWidget("Facebook", "https://www.facebook.com/melonkemo",
          icon: SimpleIcons.facebook, width: cardWidth),
      CardListWidget("Telegram", "https://t.me/melonkemo",
          icon: SimpleIcons.telegram, width: cardWidth),
      CardListWidget("Mastadon", "https://kemonodon.club/@melonkemo",
          icon: SimpleIcons.mastodon, width: cardWidth),
      CardListWidget(
          "Bluesky", "https://bsky.app/profile/melonkemo.bsky.social",
          icon: SimpleIcons.icloud, width: cardWidth),
    ];
  }

  List<Widget> _menus(BuildContext context) => [
        ..._largeMenus(context),
        const SizedBox(
          height: 6,
        ),
        _divider(context),
        ..._smallMenus(context, marginTop: 26),
      ];

  List<Widget> _smallMenus(BuildContext context, {double marginTop = 16}) => [
        SizedBox(
          height: marginTop,
        ),
        CardWidget(
          width: cardWidth,
          title: "บัญชีโซเชียล",
          children: _accounts(context),
        ),
      ];

  List<Widget> _largeMenus(BuildContext context) => [
        _profileWidget(context, betweenBottom: 12),
        CardWidget(
          width: cardWidth,
          betweenBottom: 0,
          title: "แนะนำตัว",
          leadingTitle: _langSegment(context),
          children: _about(context),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MelonScaffoldWidget(
      body: realCardWidth.resolve(context) < 880
          ? _smallLayout(context)
          : _largeLayout(context),
      children: [_background(context), _imageCredit(context)],
      overlayBody: (Widget body) => Container(
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
          ),
          child: body),
    );
  }

  Widget _background(BuildContext context) {
    String image = "assets/images/bangkok_background_image_medium.webp";
    return Container(
      color: const Color(0xFF46a1c5),
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(image, fit: BoxFit.cover),
    );
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
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
        ),
        SizedBox(
          width: 420,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
