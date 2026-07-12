import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'dart:ui' as ui;


class LegacyHomePage extends StatefulWidget {
  const LegacyHomePage({Key? key}) : super(key: key);

  @override
  _LegacyHomePageState createState() => _LegacyHomePageState();
}

class _LegacyHomePageState extends State<LegacyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black.withOpacity(0.94),
      appBar: _appBar(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context){
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return ListView(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + (mediaWidth > 750 ? 50 : 0),
          bottom: MediaQuery.of(context).viewPadding.bottom + 50),
      physics: const BouncingScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            constraints:  BoxConstraints(maxWidth: mediaWidth > 750 ? 700 : mediaWidth, minHeight: 700),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mediaWidth > 750 ? 16 : 0),
              color: Colors.grey.shade100,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                // border: Border.all(
                //     width: 8, color: Colors.black.withOpacity(0.2)),
                //color: Colors.orange.withOpacity(0.020),
              ),
              alignment: Alignment.center,
              child: const Text('Hello World'),
            ),
          ).animate().fadeIn(delay: const Duration(milliseconds: 300)).move(
              delay: const Duration(milliseconds: 300),
              begin: const Offset(0, 100),
              end: const Offset(0, 0)),
        )
      ],
    );
  }

  PreferredSizeWidget _appBar(BuildContext context){
    return AppBar(
      toolbarHeight: 46,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "メロンけも",
            style: TextStyle(
                color: Color(0xFFFFB920),
                fontSize: 24,
                fontFamily: 'KosugiMaru',
                fontWeight: FontWeight.bold),
          ).hover(x: -2),
          MelonBouncingButton.text(
              enabledHover: true,
              text: "ลงชื่อเข้าใช้",
              fontFamily: "Itim",
              textColor: Colors.black,
              fontSize: 16,
              height: 46,
              x: -2,
              borderRadius: 0,
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0),
              color: Color(0xFFFFB920)
          )
        ],
      ),
      centerTitle: false,
      backgroundColor: Colors.black,
      elevation: 0,
    );
  }
}
