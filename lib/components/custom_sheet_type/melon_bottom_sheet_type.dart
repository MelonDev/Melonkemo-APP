import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MelonBottomSheetType extends WoltBottomSheetType {
  final BoxConstraints Function(Size)? constraint;

  MelonBottomSheetType({this.constraint})
      : super(
    shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(0))),
    showDragHandle: false,
    barrierDismissible: false,
  );

  @override
  BoxConstraints layoutModal(Size availableSize) {
    return constraint?.call(availableSize) ?? super.layoutModal(availableSize);
  }
}
