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
  final Color topColor = const Color(0xFF2BC0E4);
  final Color bottomColor = const Color(0xFFEAECC6);

  //final Color bottomColor = const Color(0xFF45B649);

  //final Color? buttonTextColor = Colors.white;
  final Color? buttonTextColor = null;

  final LayoutValue<double> cardWidth = LayoutValue.builder((layout) {
    return layout.width <= 400 ? layout.width : 400;
  });

  @override
  Widget build(BuildContext context) {
    return Title(
        color: Colors.black,
        title: "メロンけも",
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              topColor,
              bottomColor,
            ],
          )),
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
                          spreadRadius: 3,
                          color: topColor.darken(.24).withOpacity(0.5),
                          offset: const Offset(0, 0.0),
                          blurRadius: 8.0,
                        )
                      ]),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          //color:Color(0xFFf1edf5)
                          //color: Colors.white
                          color: Colors.black),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 14, right: 12),
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "メロンけも",
                            style: TextStyle(
                                color: topColor.lighten(.24),
                                fontSize: 22,
                                letterSpacing: 0.0,
                                //fontFamily: 'KosugiMaru',
                                //fontFamily: 'MochiyPopOne',
                                fontFamily: 'MPlus'),
                          ),
                          MelonBouncingButton.text(
                              enabledHover: true,
                              text: "เปิดแอป",
                              fontFamily: "Itim",
                              textColor:
                                  buttonTextColor ?? bottomColor.darken(.64),
                              fontSize: 16,
                              height: 34,
                              x: -2,
                              borderRadius: 20,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              //color: bottomColor.withOpacity(0.47)
                              color: bottomColor)
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
                    card(context, betweenBottom: 10, title: "บัญชี")
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget profile(BuildContext context,{double betweenBottom = 0}) {
    return Container(
      width: cardWidth.resolve(context),
      margin: EdgeInsets.only(bottom: betweenBottom),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.green),
          ),
          Expanded(child: Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.red),
          ))
        ],
      ),
    );
  }

  Widget card(BuildContext context,
      {required String title, double betweenBottom = 0}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.6),
          borderRadius: BorderRadius.circular(10)),
      constraints: const BoxConstraints(maxHeight: 100),
      width: cardWidth.resolve(context),
      margin: EdgeInsets.only(bottom: betweenBottom),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.65),
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
                color: Colors.black.withOpacity(0.7),
                fontSize: 20,
                letterSpacing: 0.0,
                fontFamily: 'Itim',
              ),
            ),
          )
        ],
      ),
    );
  }
}
