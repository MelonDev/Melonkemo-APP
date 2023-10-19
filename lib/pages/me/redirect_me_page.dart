import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class RedirectMePage extends StatelessWidget {
  const RedirectMePage({Key? key}) : super(key: key);

  void openInWindow() {
    if (kIsWeb) {
      js.context.callMethod('open', ['https://melonkemo.carrd.co', '_self']);
    }
  }

  @override
  Widget build(BuildContext context) {
    openInWindow();
    return Container();
  }
}
