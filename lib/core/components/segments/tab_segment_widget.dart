import 'package:flutter/material.dart';

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
      {Key? key, required this.items, bool isScrollable = false, this.color,this.onChanged})
      : super(key: key) {
    this.isScrollable = items.length > 3 ? true : isScrollable;
  }

  final List<SegmentItem> items;
  final Color? color;
  late bool isScrollable;

  Function(int)? onChanged;

  @override
  State<TabSegmentWidget> createState() => _TabSegmentWidgetState();
}

class _TabSegmentWidgetState extends State<TabSegmentWidget> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          // border: Border.all(
          //   color: Colors.black.withOpacity(0.05),
          //   width: 2,
          // ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: _tabBar(context),
        ),
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(.28),
      height: 42,
      child: TabBar(
        isScrollable: widget.isScrollable,
        unselectedLabelColor: (widget.color ?? Colors.black).withOpacity(0.6),
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        physics: const BouncingScrollPhysics(),
        //indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: widget.color ?? (widget.color ?? Colors.black)),
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
    return Tab(
      child: Container(
        padding: const EdgeInsets.only(top: 2),
        constraints: const BoxConstraints(minWidth: 100),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item.name,
              style: const TextStyle(fontSize: 18, fontFamily: "Itim"),
            )
          ],
        ),
      ),
    );
  }
}

class SegmentItem {
  final String name;

  SegmentItem(this.name);
}
