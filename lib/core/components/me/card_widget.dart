import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/base_stateless_widget.dart';
import 'package:melonkemo/core/components/cupertino_card/cupertino_rounded_corners.dart';

class CardWidget extends BaseStatelessWidget {
  const CardWidget(
      {super.key,
      this.title,
        this.titleColor,
      this.betweenBottom = 0,
      this.children,
      this.leadingTitle,
        this.cardTitleColor,
        this.cardColor,
        this.sigma = 16.0,
      required super.width});

  final String? title;
  final Color? titleColor;

  final double betweenBottom;
  final List<Widget>? children;
  final Widget? leadingTitle;
  final Color? cardColor;
  final Color? cardTitleColor;
  final double sigma;

  @override
  Widget build(BuildContext context) {
    return CupertinoCard(
      elevation: 0,
      sigma: sigma,
      margin: const EdgeInsets.only(bottom: 16),
      color: cardColor ?? Colors.white.withOpacity(.28),
      radius: BorderRadius.circular(40),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            //color: Colors.white.withOpacity(.28),
            borderRadius: BorderRadius.circular(10)),
        constraints: const BoxConstraints(minHeight: 50),
        width: width.resolve(context),
        padding:
            EdgeInsets.only(top: 0, bottom: title != null ? betweenBottom : 4),
        //margin: EdgeInsets.only(bottom: betweenBottom),
        child: Column(
          children: [
            if (title != null)
              Container(
                decoration: BoxDecoration(
                  color: cardTitleColor ?? Colors.white.withOpacity(.15),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                width: width.resolve(context),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 12, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                          color: titleColor ?? Colors.black.withOpacity(0.65),
                          fontSize: 20,
                          letterSpacing: 0.0,
                          fontFamily: 'Itim',
                          fontWeight: FontWeight.bold),
                    ),
                    leadingTitle ?? const SizedBox()
                  ],
                ),
              ),
            if (children != null) const SizedBox(height: 14),
            for (Widget widget in children ?? [])
              Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: widget,
              ),
            if (children != null) const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
