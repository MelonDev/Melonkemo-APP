import 'package:flutter/material.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/pages/sushiro/dialogs/add_people_dialog.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.text, this.additionalWidget});

  final String? text;
  final Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Container(
        padding: const EdgeInsets.only(left: 40,right: 40,top: 60,bottom: 40),
        margin: const EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 12), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              style: const TextStyle(
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
        ),
      ),
    );
  }
}
