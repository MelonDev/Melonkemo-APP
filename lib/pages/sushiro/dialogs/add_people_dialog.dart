import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class AddPeopleDialog extends StatefulWidget {
  const AddPeopleDialog({
    super.key,
    required this.id,
    this.people,
    this.callback,
    this.maxWidth = 360,
    this.maxHeight = 600,
    this.borderRadius = 12
  });

  final PeopleModel? people;
  final Function(PeopleModel)? callback;
  final double maxHeight;
  final double maxWidth;
  final double borderRadius;
  final String id;

  @override
  State<AddPeopleDialog> createState() => _AddPeopleDialogState();
}

class _AddPeopleDialogState extends State<AddPeopleDialog> {
  final LayoutValue<Size> size = LayoutValue.builder((layout) {
    return Size(layout.width, layout.size.height);
  });

  var formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.people?.name ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius)
      ),
      constraints: BoxConstraints(maxWidth: widget.maxWidth,maxHeight: widget.maxHeight),
      //height: size.resolve(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(left: 20, right: 20),

            //color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.people != null ? "แก้ไขชื่อ" : "เพิ่ม"}คน",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bai',
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nameController,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Bai',
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "กรุณากรอกชื่อ";
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2.0, color: Colors.red),
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
                            fontFamily: 'Bai',
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Bai',
                          ),
                          labelStyle: TextStyle(
                            color: Colors.red,
                          ),
                          hintText: "ชื่อ",
                          fillColor: Colors.black.withOpacity(0.05),
                        ),
                      ),
                      const SizedBox(height: 26),
                    ]),
              )),
          Container(
              padding: const EdgeInsets.only(bottom: 16,right: 20,left:20),
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
                              left: 46, right: 46, bottom: 10, top: 10),
                          child: const Text(
                            "ยกเลิก",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Bai',
                                color: Colors.black),
                          ),
                        )),
                    MelonBouncingButton(
                        callback: () {
                          if (formkey.currentState?.validate() ?? false) {
                            widget.callback?.call(PeopleModel(
                              widget.id,
                              nameController.text,
                              copper: widget.people?.copper,
                              silver: widget.people?.silver,
                              gold: widget.people?.gold,
                              black: widget.people?.black,
                              plates: widget.people?.plates,
                            ));
                            Navigator.of(context).pop();
                          }
                        },
                        borderRadius: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.only(
                              left: 46, right: 46, bottom: 10, top: 10),
                          child: const Text(
                            "ยืนยัน",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Bai',
                                color: Colors.black),
                          ),
                        )),
                  ]))
        ],
      ),
    );
  }
}

WoltModalSheetPage addPeoplePage(
    BuildContext modalSheetContext, TextTheme textTheme,
    {required String id,
    PeopleModel? people,
    Function(PeopleModel)? callback,
    double pageHeight = 0.4}) {
  return WoltModalSheetPage(
    hasSabGradient: false,
    forceMaxHeight: false,
    navBarHeight: 0,
    backgroundColor: Colors.white,
    isTopBarLayerAlwaysVisible: false,
    child: AddPeopleDialog(
      id: id,
      people: people,
      callback: callback,
    ),
  );
}
