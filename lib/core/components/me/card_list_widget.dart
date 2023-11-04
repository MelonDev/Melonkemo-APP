import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:melonkemo/core/components/base_stateless_widget.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/bot_toast_extension.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class CardListWidget extends BaseStatelessWidget {
  const CardListWidget(this.serviceName, this.link,
      {super.key, this.serviceTextColor, this.icon, required super.width});

  final String serviceName;
  final String link;
  final Color? serviceTextColor;
  final double betweenBottom = 10;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return MelonBouncingButton(
        callback: () {
          Future.delayed(const Duration(milliseconds: 300)).then((value) {
            _launchUrl(link);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.35),
            borderRadius: BorderRadius.circular(12),
          ),
          width: width.resolve(context),
          constraints: const BoxConstraints(minHeight: 40),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: betweenBottom),
          padding:
              const EdgeInsets.only(left: 22, right: 22, bottom: 18, top: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                serviceName,
                style: TextStyle(
                    color: (serviceTextColor ?? Colors.black).withOpacity(0.70),
                    fontSize: 17,
                    letterSpacing: 0.0,
                    fontFamily: 'VarelaRound',
                    fontWeight: FontWeight.bold),
              ),
              if (icon != null)
                Icon(
                  icon,
                  size: 24,
                  color: (serviceTextColor ?? Colors.black).withOpacity(0.70),
                ),
            ],
          ),
        )).hover(x: -10.0, z: 1.05);
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
    } else {
      BotToast().component.error('Could not launch $url');
    }
  }
}
