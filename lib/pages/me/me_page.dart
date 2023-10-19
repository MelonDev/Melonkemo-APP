import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:flutter_animate/flutter_animate.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  double widget1Opacity = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      widget1Opacity = 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: kIsWeb
              ? null
              : Platform.isAndroid
                  ? const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light)
                  : null,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        //fit: StackFit.expand,
        children: [_background(context), _content(context)],
      ),
    );
  }

  Widget _content(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return ListView(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 50,
          bottom: MediaQuery.of(context).viewPadding.bottom + 50),
      physics: const BouncingScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 560, minHeight: 700),
              // width: mediaWidth <= 560 ? mediaWidth : 560,
              // height: mediaHeight <= 700 ? mediaHeight : 700,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black.withOpacity(0.25),
                boxShadow: [
                  BoxShadow(
                      //spreadRadius: 3,
                      spreadRadius: 6.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0.0, 0.0),
                      //blurRadius: 8.0,
                      blurRadius: 6.0)
                ],
              ),
              //padding: EdgeInsets.all(8),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 12.0,
                    sigmaY: 12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                          width: 8, color: Colors.black.withOpacity(0.2)),
                      color: Colors.orange.withOpacity(0.020),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Hello World'),
                  ),
                ).animate().fadeIn(duration: const Duration(milliseconds: 300)),
              ),
            ).animate().fadeIn(delay: const Duration(seconds: 0)).move(
                delay: const Duration(milliseconds: 300),
                begin: const Offset(0, 100),
                end: const Offset(0, 0)),
          ),
        )
      ],
    );
  }

  Widget _background(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/bg.webp",
          fit: BoxFit.cover,
          scale: 1,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.75),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
