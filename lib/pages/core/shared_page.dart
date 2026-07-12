import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:melonkemo/core/core/core_route.dart';
import 'package:melonkemo/core/extensions/bot_toast_extension.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SharedPage extends StatelessWidget {
  SharedPage({super.key, required this.url}) {
    openInWindow();
  }

  static RouteBase route({required String path, required String url}) =>
      CoreRoute.url('/shared/$path', url);

  final String url;

  void openInWindow() {
    if (kIsWeb) {
      _launchUrl(url);
    }
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.platformDefault,
        //webOnlyWindowName: '_blank',
        webOnlyWindowName: '_self',
      );
    } else {
      BotToast().component.error('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) => Container();
}
