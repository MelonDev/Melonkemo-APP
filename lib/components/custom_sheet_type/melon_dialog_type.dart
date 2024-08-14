import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MelonDialogType extends WoltDialogType {
  final BoxConstraints Function(Size)? constraint;

  MelonDialogType({this.constraint})
      : super(
    shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))),
    barrierDismissible: false,
  );

  @override
  BoxConstraints layoutModal(Size availableSize) {
    return constraint?.call(availableSize) ?? super.layoutModal(availableSize);
  }
}
