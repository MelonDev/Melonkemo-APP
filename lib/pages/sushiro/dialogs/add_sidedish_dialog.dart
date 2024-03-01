import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class AddSidedishDialog extends StatefulWidget {
  const AddSidedishDialog(
      {super.key,
      this.plate,
      this.callback,
      this.pageHeight = 0.4,
      this.index});

  final SideDishPlateModel? plate;
  final Function(int?, SideDishPlateModel)? callback;
  final double pageHeight;
  final int? index;

  @override
  State<AddSidedishDialog> createState() => _AddSidedishDialogState();
}

class _AddSidedishDialogState extends State<AddSidedishDialog> {
  late StreamSubscription<bool> keyboardSubscription;
  bool isKeyboardShown = false;

  final LayoutValue<Size> size = LayoutValue.builder((layout) {
    return Size(layout.width, layout.size.height);
  });

  var formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int value = 0;

  @override
  void initState() {
    nameController.text = widget.plate?.name ?? "";
    priceController.text = widget.plate?.price.toStringAsFixed(0) ?? "";
    value = widget.plate?.value ?? 0;
    var keyboardVisibilityController = KeyboardVisibilityController();

    super.initState();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
          isKeyboardShown = visible;
          setState(() {});
          print('Keyboard visibility update. Is visible: $visible');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.resolve(context).height * widget.pageHeight,
      child: Column(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(left: 20, right: 20),

            //color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.plate != null ? "แก้ไข" : "เพิ่ม"}จาน",
                  //" ${size.resolve(context).height} ${isKeyboardShown}",

                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Itim',
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _textfield(nameController, "ชื่อ"),
                        const SizedBox(height: 16),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:_textfield(priceController, "ราคา",
                                  inputType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ]),
                            ),
                            const SizedBox(width: 16),
                             Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MelonBouncingButton(
                                      callback: () {
                                        if (value > 0) {
                                          value -= 1;
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(100)),
                                        child: const Icon(
                                          CupertinoIcons.minus,
                                          size: 22,
                                        ),
                                      )).hover(y: -1, x: -0.5),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    value.toString(),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Itim',
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  MelonBouncingButton(
                                      callback: () {
                                        value += 1;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(100)),
                                        child: const Icon(
                                          CupertinoIcons.add,
                                          size: 24,
                                        ),
                                      )).hover(y: -1, x: -0.5)
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 26),
                      ]),
                )),
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MelonBouncingButton(
                        callback: () {
                          Navigator.of(context).pop();
                        },
                        borderRadius: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 10, top: 10),
                          child: const Text(
                            "ยกเลิก",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Itim',
                                color: Colors.black),
                          ),
                        )),
                    MelonBouncingButton(
                        callback: () {
                          if (formkey.currentState?.validate() ?? false) {
                            widget.callback?.call(
                                widget.index,
                                SideDishPlateModel(
                                    nameController.text,
                                    priceController.text.toDouble(),
                                    value));
                            Navigator.of(context).pop();
                          }
                        },
                        borderRadius: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 10, top: 10),
                          child: const Text(
                            "ยืนยัน",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Itim',
                                color: Colors.black),
                          ),
                        )),
                  ]))
        ],
      ),
    );
  }

  Widget _textfield(TextEditingController controller, String hint,
      {TextInputType? inputType, List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 20,
        fontWeight: FontWeight.normal,
        fontFamily: 'Itim',
      ),
      inputFormatters: inputFormatters ?? [],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return "กรุณากรอก$hint";
        }
      },
      keyboardType: inputType ?? TextInputType.name,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'Itim',
        ),
        hintStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 20,
          fontWeight: FontWeight.normal,
          fontFamily: 'Itim',
        ),
        labelStyle: TextStyle(
          color: Colors.red,
        ),
        hintText: hint,
        fillColor: Colors.black.withOpacity(0.05),
      ),
    );
  }
}

WoltModalSheetPage addSideDishPage(
    BuildContext modalSheetContext, TextTheme textTheme,
    {int? index,
    SideDishPlateModel? plate,
    Function(int?, SideDishPlateModel)? callback,
    double pageHeight = 0.4}) {
  return WoltModalSheetPage(
    hasSabGradient: false,
    forceMaxHeight: false,
    navBarHeight: 0,
    backgroundColor: Colors.white,
    isTopBarLayerAlwaysVisible: false,
    child: AddSidedishDialog(
      index: index,
      plate: plate,
      callback: callback,
      pageHeight: pageHeight,
    ),
  );
}
