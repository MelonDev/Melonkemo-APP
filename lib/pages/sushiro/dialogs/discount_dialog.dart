import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog(
      {super.key,
      this.callback,
      this.maxWidth = 360,
      this.maxHeight = 600,
      this.borderRadius = 16,
      this.voucher});

  final Function(VoucherDiscountModel)? callback;
  final double maxHeight;
  final double maxWidth;
  final double borderRadius;
  final VoucherDiscountModel? voucher;

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  late final VoucherDiscountModel voucher;

  @override
  void initState() {
    voucher = widget.voucher?.copy() ?? VoucherDiscountModel();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(left: 20, right: 20),
            //color: Colors.blue,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ส่วนลด",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bai',
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            margin: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "คูปองเงินสด",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Bai',
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    children: [
                      _noPrice(),
                      _price(20),
                      _price(40),
                      _price(60),
                      _price(80),
                      _price(120),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "คูปองท้ายใบเสร็จ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Bai',
                      color: Colors.black),
                ),
                CupertinoSwitch(
                    value: voucher.receipt != null,
                    activeColor: Colors.amberAccent,
                    onChanged: (value) {
                      voucher.receipt =
                          value == true ? ReceiptVoucherModel() : null;
                      setState(() {});
                    })
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                          child: Text(
                            "ยกเลิก",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Bai',
                                color: Colors.black.withOpacity(0.75)),
                          ),
                        ))),
                Container(
                  width: 10,
                ),
                Expanded(
                  child: MelonBouncingButton(
                    callback: () {
                      widget.callback?.call(voucher);
                      Navigator.of(context).pop();
                    },
                    borderRadius: 100,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(100)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 10, top: 10),
                      child: Text(
                        "ยืนยัน",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Bai',
                            color: Colors.black.withOpacity(0.75)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _price(int price) {
    bool isSelected = voucher.cash?.value == price;
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 60),
      padding: const EdgeInsets.only(left: 4.0, top: 4.0),
      child: MelonBouncingButton.text(
          text: price.toString(),
          color: isSelected ? Colors.amberAccent : Colors.grey.shade200,
          textColor: Colors.black,
          fontSize: 18,
          padding: const EdgeInsets.only(left: 8, right: 8),
          borderRadius: 8,
          fontFamily: "Bai",
          callback: () {
            voucher.cash = CashVoucherModel(price.toDouble());
            setState(() {});
          }),
    );
  }

  Widget _noPrice() {
    bool isSelected = voucher.cash == null;
    return Container(
      padding: const EdgeInsets.only(left: 4.0, top: 4.0),
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 80),
      child: MelonBouncingButton.text(
          text: "ไม่เลือก",
          color: isSelected ? Colors.grey.shade600 : Colors.grey.shade200,
          textColor: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          padding: const EdgeInsets.only(left: 8, right: 8),
          borderRadius: 8,
          fontFamily: "Bai",
          callback: () {
            voucher.cash = null;
            setState(() {});
          }),
    );
  }
}
