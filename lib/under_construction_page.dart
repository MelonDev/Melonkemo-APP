import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class UnderConstructionPage extends StatefulWidget {
  const UnderConstructionPage({Key? key}) : super(key: key);

  @override
  _UnderConstructionPageState createState() => _UnderConstructionPageState();
}

class _UnderConstructionPageState extends State<UnderConstructionPage> {
  // Controller for playback
  late RiveAnimationController _controller;

  // Toggles between play and pause animation states
  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 6,
            ),
            const Text(
              "メロンけも",
              style: TextStyle(
                  color: Color(0xFFFFB920),
                  fontSize: 32,
                  fontFamily: 'KosugiMaru',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              "melonkemo.com",
              style: TextStyle(
                  color: Color(0xFFFFB920).withOpacity(0.9),
                  fontSize: 22,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFB920),
      body: Column(
        children:  [
          const Expanded(
              child: RiveAnimation.asset(
            'assets/rive/cat_translucent.riv',
          )),
          Container(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              children: [
                AutoSizeText(
                  "This page is under construction",
                  maxFontSize: 32,
                  maxLines: 1,
                  minFontSize: 28,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6,),
                AutoSizeText(
                  "เพจนี้ในขั้นตอนการพัฒนา",
                  maxFontSize: 24,
                  maxLines: 1,
                  minFontSize: 20,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8,),
                AutoSizeText(
                  "このページは作成中です",
                  maxFontSize: 18,
                  maxLines: 1,
                  minFontSize: 14,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'KosugiMaru',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
