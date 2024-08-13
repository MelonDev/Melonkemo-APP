import 'package:flutter/material.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/pages/sushiro/dialogs/add_people_dialog.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.text, this.additionalWidget});

  final String? text;
  final Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 100,
          height: 100,
          child: Image.asset(
            "assets/icons/web_icon.png",
            height: 100,
            width: 100,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text ?? "ว่างเปล่า",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Bai',
          ),
        ),
        if (additionalWidget != null)
          const SizedBox(
            height: 30,
          ),
        if (additionalWidget != null) additionalWidget!,

      ],
    );
  }
}
