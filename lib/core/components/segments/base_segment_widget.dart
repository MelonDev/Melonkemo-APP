import 'package:flutter/cupertino.dart';

typedef SegmentBody = Widget Function(BuildContext context);

abstract class BaseSegmentWidget extends StatefulWidget {
  BaseSegmentWidget({super.key, bool isScrollable = false}) {
    this.isScrollable = items.length > 3 ? true : isScrollable;
  }

  List<SegmentItem> get items;

  late bool isScrollable;

  Function(BuildContext)? body;

  @override
  _BaseSegmentWidgetState createState() => _BaseSegmentWidgetState();
}

class _BaseSegmentWidgetState extends State<BaseSegmentWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.body?.call(context) ?? Container();
  }
}

class SegmentItem {}
