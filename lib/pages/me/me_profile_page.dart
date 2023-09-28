import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/color_extension.dart';
import 'package:melonkemo/core/extensions/context_extension.dart';

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
  //final Color topColor = const Color(0xFF2BC0E4);
  //final Color bottomColor = const Color(0xFFEAECC6);
  final Color topColor = const Color(0xFF000000);
  final Color bottomColor = const Color(0xFFBFBFBF);


  //final Color bottomColor = const Color(0xFF45B649);

  //final Color? buttonTextColor = Colors.white;
  final Color? buttonTextColor = null;

  final LayoutValue<double> cardWidth = LayoutValue.builder((layout) {
    return layout.width <= 400 ? layout.width : 400;
  });

  @override
  Widget build(BuildContext context) {
    return Title(
        color: Colors.white,
        title: "メロンけも",
        child: Container(
          decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     topColor,
          //     bottomColor,
          //   ],
          // ),
            color: Colors.black,
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
                          blurRadius: 0.0
                        )
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
                          ),
                          MelonBouncingButton.text(
                              enabledHover: true,
                              text: "เปิดแอป",
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
                            color: Colors.black.withOpacity(0.8)
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20, bottom: 20),
              child: Container(
                width: context.layout.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //profile(context, betweenBottom: 10),
                    card(context, betweenBottom: 10, title: "เกี่ยวกับ"),
                    card(context,
                        betweenBottom: 10, title: "บัญชี", children: account())
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget profile(BuildContext context, {double betweenBottom = 0}) {
    return Container(
      width: cardWidth.resolve(context),
      margin: EdgeInsets.only(bottom: betweenBottom),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(color: Colors.green),
          ),
          Expanded(
              child: Container(
            height: 100,
            decoration: const BoxDecoration(color: Colors.red),
          ))
        ],
      ),
    );
  }

  List<Widget> account() {
    return [linkCard("Twitter","CKMelonDev",serviceTextColor: Colors.blue), linkCard("Instagram","CKMelonDev",serviceTextColor:Colors.purpleAccent)];
  }

  Widget linkCard(String serviceName, String linkMessage,
      {Color? serviceTextColor,double betweenBottom = 10}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.65),
        borderRadius: BorderRadius.circular(10),
      ),
      width: cardWidth.resolve(context),
      constraints: const BoxConstraints(minHeight: 40),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: betweenBottom),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            serviceName,
            style: TextStyle(
                color: (serviceTextColor ?? Colors.black).withOpacity(0.95),
                fontSize: 16,
                letterSpacing: 0.0,
                fontFamily: 'Itim',
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            linkMessage,
            style: TextStyle(
                color: Colors.black.withOpacity(0.85),
                fontSize: 18,
                letterSpacing: 0.0,
                fontFamily: 'Itim',
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget card(BuildContext context,
      {required String title,
      double betweenBottom = 0,
      List<Widget>? children}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.28),
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
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            width: cardWidth.resolve(context),
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 20,
                letterSpacing: 0.0,
                fontFamily: 'Itim',
              ),
            ),
          ),
          if (children != null) SizedBox(height: 10),
          for (Widget widget in children ?? []) widget
        ],
      ),
    );
  }
}
