import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/components/pro_animated_blur.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/components/cupertino_card/cupertino_rounded_corners.dart';
import 'package:melonkemo/core/components/me/card_list_widget.dart';
import 'package:melonkemo/core/components/me/card_widget.dart';
import 'package:melonkemo/core/components/me/melon_scaffold_widget.dart';
import 'package:melonkemo/core/components/segments/tab_segment_widget.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/home/prototype_home_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_icons/simple_icons.dart';

class PrototypeHomePage extends StatefulWidget {
  const PrototypeHomePage({Key? key}) : super(key: key);

  @override
  _PrototypeHomePageState createState() => _PrototypeHomePageState();
}

class _PrototypeHomePageState extends State<PrototypeHomePage> {
  //late final DraggableScrollableController _controller ;
  late final PrototypeHomeProvider _provider;
  late final ScrollController _scrollController;

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

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      bool notifyBg = false;
      bool notifyAb = false;

      if (realCardWidth.resolve(context) < 1036) {
        notifyBg = _provider.setBlur(_scrollController.offset);
        notifyAb = _provider.setAppbarBlur(0.0);
      } else {
        notifyBg = _provider.setBlur(0.0);
        notifyAb = _provider.setAppbarBlur(_scrollController.offset);
      }
      if (notifyAb == true || notifyBg == true) {
        _provider.notifyListeners();
      }
    });

    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (BuildContext ct, Widget? widget) {
          bool isAppbarBlur = ct.watch<PrototypeHomeProvider>().isAppbarBlur;

          return MelonScaffoldWidget(
            body: _layout(ct)
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 300))
                .move(
                    delay: const Duration(milliseconds: 500),
                    begin: const Offset(0, 100),
                    end: const Offset(0, 0)),
            extendBodyBehindAppBar: true,
            appBarColor: Colors.black.withOpacity(isAppbarBlur ? 0.1 : 0.0),
            appBarNameTitleColor: Colors.white,
            customAppbarBody: (double height, Widget body) {
              return ClipRect(
                child: SizedBox(
                    height: height,
                    child: ProAnimatedBlur(
                      blur: isAppbarBlur ? 20 : 2,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear,
                      child: body,
                    )),
              );
            },
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
    double topPadding = MediaQuery.of(context).size.height * 0.55;
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
        child: ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: topPadding + 46, bottom: 60),
          children: [
            _profileWidget(context),
            CardWidget(
              cardTitleColor: Colors.white.withOpacity(.0),
              //cardColor: Colors.grey.withOpacity(.48),
              cardColor: Colors.white.withOpacity(.55),
              //titleColor: Colors.white.withOpacity(.9),
              width: cardWidth,
              sigma: 22,
              betweenBottom: 0,
              title: "แนะนำตัว",
              leadingTitle: _langSegment(context),
              children: _about(context),
            ),
            _divider(context),
            CardWidget(
              cardTitleColor: Colors.white.withOpacity(.0),
              cardColor: Colors.grey.shade600.withOpacity(.38),
              titleColor: Colors.white.withOpacity(.9),
              sigma: 42,
              width: cardWidth,
              betweenBottom: 0,
              title: "บัญชีโซเชียล",
              children: _accounts(context),
            ),
            // CardWidget(
            //   cardTitleColor: Colors.white.withOpacity(.0),
            //   //cardColor: Color(0xFFCFCFCF).withOpacity(.48),
            //   cardColor: Colors.grey.shade600.withOpacity(.48),
            //   titleColor: Colors.white.withOpacity(.9),
            //   width: cardWidth,
            //   sigma: 22,
            //   betweenBottom: 0,
            //   title: "ทดสอบ",
            //   children: [Container(height: 150)],
            // ),
          ],
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: realCardWidth.resolve(context) <= 600
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20 + extraWidth),
          constraints: realCardWidth.resolve(context) <= 600
              ? const BoxConstraints(maxWidth: 420)
              : null,
          width: contentWidth ?? realCardWidth.resolve(context) - 550,
          child: realCardWidth.resolve(context) <= 600
              ? listContainer
              : Row(
                  mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
                  children: [listContainer],
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
    bool isBlur = context.watch<PrototypeHomeProvider>().isBGBlur;
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _image(context),
            fit: BoxFit.cover,
            alignment: realCardWidth.resolve(context) > 600
                ? Alignment.centerRight
                : Alignment.center,
          ),
          ProAnimatedBlur(
            blur: isBlur ? 10 : 0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            child: Container(),
          )
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
    bool isBlur = context.watch<PrototypeHomeProvider>().isBGBlur;

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
            //height: 160,
            //padding: const EdgeInsets.only(left: 16),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'メロン',
                  style: TextStyle(
                      shadows: realCardWidth.resolve(context) < 600 && !isBlur ? <Shadow>[
                        Shadow(
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 12.0,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ] : null,
                      color: Colors.white.withOpacity(realCardWidth.resolve(context) < 600 && !isBlur ? 1.0 : 0.92),
                      fontSize: 52,
                      letterSpacing: 0.0,
                      fontFamily: 'MPlus',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 0),
                Text(
                  'Melon | เมล่อน',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 24,
                      letterSpacing: 0.0,
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  '26 • Male (Pan) • INFJ • Thai & English • Software Engineer',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 18,
                      letterSpacing: 0.0,
                      fontFamily: 'Itim',
                      //fontFamilyFallback: const [ 'Itim','Apple Color Emoji', ],
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ))
        ],
      ),
    );
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
            Color(0xFFCFCFCF).withOpacity(.0),
            Color(0xFFCFCFCF).withOpacity(.58),
            Color(0xFFCFCFCF).withOpacity(.58),
            Color(0xFFCFCFCF).withOpacity(.58),
            Color(0xFFCFCFCF).withOpacity(.0),
          ],
        ),
      ),
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 16),
    );
  }

  Widget _langSegment(BuildContext context) {
    List<SegmentItem<AboutLanguage>> langItems = [
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
            backgroundColor: Colors.black.withOpacity(0.12),
            //backgroundColor: Colors.red,
            itemFontSize: 14,
            minWidth: 20,
            items: langItems,
            onChanged: (int index) {
              if (langItems[index].value != null) {
                context
                    .read<PrototypeHomeProvider>()
                    .setLang(langItems[index].value!);
              }
              setState(() {});
            },
          ),
        );
      }),
    );
  }

  List<Widget> _about(BuildContext context) {
    AboutLanguage language = context.watch<PrototypeHomeProvider>().language;
    return [
      if (language == AboutLanguage.thai)
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
        )
            .animate(key: const Key("TH"))
            .fadeIn(delay: const Duration(milliseconds: 200)),
      if (language == AboutLanguage.thai) const SizedBox(height: 16),
      if (language == AboutLanguage.english)
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
                ))
            .animate(key: const Key("EN"))
            .fadeIn(delay: const Duration(milliseconds: 200)),
      if (language == AboutLanguage.english) const SizedBox(height: 16),
      if (language == AboutLanguage.japanese)
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
                ))
            .animate(key: const Key("JP"))
            .fadeIn(delay: const Duration(milliseconds: 200)),
      if (language == AboutLanguage.japanese) const SizedBox(height: 16),
    ];
  }

  List<Widget> _accounts(BuildContext context) {
    return [
      CardLinkWidget("Twitter", "https://twitter.com/melonkemo",
          icon: SimpleIcons.twitter),
      CardLinkWidget("Facebook", "https://www.facebook.com/melonkemo",
          icon: SimpleIcons.facebook),
      CardLinkWidget("Telegram", "https://t.me/melonkemo",
          icon: SimpleIcons.telegram),
      CardLinkWidget("Mastadon", "https://kemonodon.club/@melonkemo",
          icon: SimpleIcons.mastodon),
      CardLinkWidget(
          "Bluesky", "https://bsky.app/profile/melonkemo.bsky.social",
          icon: SimpleIcons.icloud),
    ];
  }

  Widget CardLinkWidget(String title, String link, {IconData? icon}) =>
      CardListWidget(
        title,
        link,
        icon: icon,
        width: cardWidth,
        backgroundColor: Colors.black.withOpacity(0.2),
        serviceTextColor: Colors.white,
        serviceTextOpacity: 0.8,
      );
}
