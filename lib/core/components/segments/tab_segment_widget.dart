import 'package:flutter/material.dart';
import 'package:melonkemo/core/components/bouncing/melon_bounce_widget.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';

import 'base_segment_widget.dart';

// class TabSegmentWidget extends BaseSegmentWidget {
//   TabSegmentWidget({super.key});
//
//   @override
//   List<SegmentItem> get items => [];
//
//
//
// }

class TabSegmentWidget extends StatefulWidget {
  TabSegmentWidget(
      {Key? key,
      required this.items,
      bool isScrollable = false,
      this.color,
        this.controller,
      this.onChanged,
      this.backgroundColor,
      this.borderRadius = 40,
        this.itemFontSize = 18,
        this.minWidth = 100,
      this.height = 30})
      : super(key: key) {
    this.isScrollable = items.length > 3 ? true : isScrollable;
  }

  final TabController? controller;
  final List<SegmentItem> items;
  final Color? color;
  final Color? backgroundColor;

  late bool isScrollable;
  final double borderRadius;
  final double height;
  final double itemFontSize;
  final double minWidth;

  Function(int)? onChanged;

  @override
  State<TabSegmentWidget> createState() => _TabSegmentWidgetState();
}

class _TabSegmentWidgetState extends State<TabSegmentWidget> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.height),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          // border: Border.all(
          //   color: Colors.black.withOpacity(0.05),
          //   width: 2,
          // ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: _tabBar(context),
        ),
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.white.withOpacity(.28),
      height: widget.borderRadius + 2,
      child: TabBar(
        controller: widget.controller,
        isScrollable: widget.isScrollable,
        unselectedLabelColor: (widget.color ?? Colors.black).withOpacity(0.6),
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        physics: const BouncingScrollPhysics(),
        //indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.color ?? Colors.black),
        onTap: (int index) {
          widget.onChanged?.call(index);
          setState(() {
            position = index;
          });
        },
        tabs: widget.items
            .asMap()
            .entries
            .map((item) => _tabItem(context, item.key))
            .toList(),
      ),
    );
  }

  Widget _tabItem(BuildContext context, int index) {
    SegmentItem item = widget.items[index];
    return MelonBouncingButton(callback: (){
      widget.controller?.animateTo(index);
      widget.onChanged?.call(index);
      setState(() {
        position = index;
      });
    },child: Container(
        padding: const EdgeInsets.only(top: 2),
        constraints: BoxConstraints(minWidth: widget.minWidth),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item.name,
              style: TextStyle(fontSize: item.config?.fontSize ?? widget.itemFontSize, fontFamily: item.config?.fontFamily ?? "Itim"),
            )
          ],
        ),
      ),).hover(x: -1,z: 1.06);
    return Tab(
      child: Container(
        padding: const EdgeInsets.only(top: 2),
        constraints: BoxConstraints(minWidth: widget.minWidth),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item.name,
              style: TextStyle(fontSize: item.config?.fontSize ?? widget.itemFontSize, fontFamily: item.config?.fontFamily ?? "Itim"),
            )
          ],
        ),
      ).hover(x: -1),
    );
  }
}

class SegmentItem<T>{
  final String name;
  final SegmentConfigItem? config;
  final T? value;

  SegmentItem(this.name,{this.config,this.value});
}

class SegmentConfigItem {
  final double? fontSize;
  final String? fontFamily;

  SegmentConfigItem({this.fontSize, this.fontFamily});
}