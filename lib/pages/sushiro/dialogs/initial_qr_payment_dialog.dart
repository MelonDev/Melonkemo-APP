import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';

class InitialQrPaymentDialog extends StatefulWidget {
  const InitialQrPaymentDialog(
      {super.key,
      this.id,
      this.callback,
      this.maxWidth = 360,
      this.maxHeight = 600,
      this.borderRadius = 20});

  final Function(String)? callback;
  final double maxHeight;
  final double maxWidth;
  final double borderRadius;
  final String? id;

  @override
  State<InitialQrPaymentDialog> createState() => _InitialQrPaymentDialogState();
}

class _InitialQrPaymentDialogState extends State<InitialQrPaymentDialog> {
  var formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.id ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      constraints: BoxConstraints(
          maxWidth: widget.maxWidth, maxHeight: widget.maxHeight),
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
                  "พร้อมเพย์ QR",
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
                            return "กรุณากรอกเลขพร้อมเพย์";
                          }
                          if((value?.length ?? 0) < 10 || ((value?.length ?? 0) > 10) && (value?.length ?? 0) < 13){
                            return "กรุณากรอกเลขพร้อมเพย์";
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2.0, color: Colors.red),
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
                          hintText: "เลขพร้อมเพย์",
                          fillColor: Colors.black.withOpacity(0.05),
                        ),
                      ),
                      const SizedBox(height: 26),
                    ]),
              )),
          Container(
              padding: const EdgeInsets.only(bottom: 16, right: 20, left: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if(nameController.text.isNotEmpty)
                    MelonBouncingButton(
                        callback: () {
                          widget.callback?.call("");
                          Navigator.of(context).pop();
                        },
                        borderRadius: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          alignment: Alignment.center,

                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          child: const Icon(
                            CupertinoIcons.trash,
                            size: 24,
                          ),
                        )),
                    if(nameController.text.isNotEmpty)
                      Container(
                      width: 10,
                    ),
                    Expanded(
                      child: MelonBouncingButton(
                          callback: () {

                            Navigator.of(context).pop();
                          },
                          borderRadius: 100,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(100)),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, bottom: 10, top: 10),
                            child: const Text(
                              "ยกเลิก",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Bai',
                                  color: Colors.black),
                            ),
                          )),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                        child: MelonBouncingButton(
                            callback: () {
                              if ((formkey.currentState?.validate() ?? false) &&
                                  (nameController.text.length == 10 ||
                                      nameController.text.length == 13)) {
                                widget.callback?.call(nameController.text);
                                Navigator.of(context).pop();
                              }
                            },
                            borderRadius: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(100)),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 10, top: 10),
                              child: const Text(
                                "ยืนยัน",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Bai',
                                    color: Colors.black),
                              ),
                            ))),
                  ]))
        ],
      ),
    );
  }
}
