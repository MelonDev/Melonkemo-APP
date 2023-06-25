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
  //final Color bottomColor = const Color(0xFFEAECC6);
  final Color bottomColor = const Color(0xFF45B649);

  //final Color? buttonTextColor = Colors.white;
  final Color? buttonTextColor = null;

  @override
  Widget build(BuildContext context) {
    return Title(
        color: Colors.white,
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
                          color: Colors.white),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      height: 46,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "メロンけも",
                            style: TextStyle(
                                color: topColor.darken(.24),
                                fontSize: 21,
                                //fontFamily: 'KosugiMaru',
                                fontFamily: 'MochiyPopOne',
                                fontWeight: FontWeight.bold),
                          ),
                          MelonBouncingButton.text(
                              enabledHover: true,
                              text: "เปิดแอป",
                              textColor: buttonTextColor ?? topColor.darken(.24),
                              fontSize: 16,
                              height: 34,
                              x: -2,
                              borderRadius: 20,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              color: bottomColor.withOpacity(0.17))
                        ],
                      ),
                    ),
                  ],
                )),
            backgroundColor: Colors.transparent,
          ),
        ));
  }
}
