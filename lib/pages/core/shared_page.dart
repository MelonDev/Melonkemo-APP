import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:go_router/go_router.dart';

class SharedPage extends StatelessWidget {
  SharedPage({super.key,required this.url}){
    openInWindow();
  }

  static GoRoute route({required String path,required String url}){
    return GoRoute(
      path: '/shared/$path',
      builder: (context, state) => SharedPage(url: url,),
    );
  }

  final String url;

  void openInWindow() {
    if (kIsWeb) {
      js.context.callMethod('open', [url, '_self']);
    }
  }

  @override
  Widget build(BuildContext context) => Container();
}
