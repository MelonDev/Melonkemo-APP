import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';

typedef OverlayWidget = Widget Function(Widget body);

class MelonScaffoldWidget extends StatelessWidget {
  const MelonScaffoldWidget({super.key, this.children, this.overlayBody, required this.body});

  final List<Widget>? children;
  final OverlayWidget? overlayBody;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.white,
      title: "メロンけも",
      child: Stack(
        children: [
          ...?children,
          overlayBody != null
              ? overlayBody!.call(_area(context))
              : _area(context),
        ],
      ),
    );
  }

  Widget _area(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: appbar(context),
          backgroundColor: Colors.transparent,
          body: body,
        ),
      );

  PreferredSizeWidget appbar(BuildContext) => PreferredSize(
    preferredSize: const Size.fromHeight(46.0),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 14, right: 12),
          height: 46,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "メロンけも",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 22,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MPlus'),
              ).hover(x: -2),
              MelonBouncingButton.text(
                  enabledHover: true,
                  text: "ลงชื่อเข้าใช้",
                  fontFamily: "Itim",
                  textColor: Colors.white,
                  fontSize: 16,
                  height: 34,
                  x: -2,
                  borderRadius: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: Colors.black.withOpacity(0.8))
            ],
          ),
        ),
      ],
    ),
  );
}
