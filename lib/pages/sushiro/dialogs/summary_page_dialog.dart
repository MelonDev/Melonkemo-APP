import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/double_extension.dart';
import 'package:melonkemo/core/extensions/string_extension.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/sushiro/dialogs/discount_dialog.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_provider.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'initial_qr_payment_dialog.dart';

class SummaryPageDialog extends StatefulWidget {
  const SummaryPageDialog({super.key, required this.peoples});

  final List<PeopleModel> peoples;

  @override
  State<SummaryPageDialog> createState() => _SummaryPageDialogState();
}

class _SummaryPageDialogState extends State<SummaryPageDialog> {
  final LayoutValue<Size> size = LayoutValue.builder((layout) {
    return Size(layout.width, layout.size.height);
  });
  late final SharedPreferences prefs;

  String? accountId;
  late VoucherDiscountModel? voucher;
  double discountPerPerson = 0.00;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    double price = 0.0;

    widget.peoples.forEach((people) {
      price += SushiroMainProvider.calculatePricing(
          people: people, includeServiceCharge: true);
    });
    voucher = price >= 400 ? VoucherDiscountModel() : null;

    prefs = await SharedPreferences.getInstance();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      accountId = prefs.getString("ACCOUNT_ID");
      setState(() {});
    });
  }

  Future<void> _changeAccount(String accountId) async {
    if (accountId.isNotEmpty) {
      this.accountId = accountId;
      await prefs.setString("ACCOUNT_ID", accountId);
    } else {
      await prefs.remove("ACCOUNT_ID");
      this.accountId = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.resolve(context).width < 560
          ? size.resolve(context).height * 0.95
          : size.resolve(context).height * 0.85,
      child: Column(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(left: 20, right: 20),

            //color: Colors.blue,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: MelonBouncingButton(
                    callback: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        "สรุปยอด",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Bai',
                            color: Colors.black),
                      ),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: MelonBouncingButton.text(
                            text: accountId ?? "ตั้งค่าพร้อมเพย์ QR",
                            color: const Color(0xFF0F3E84),
                            textColor: Colors.white,
                            fontSize: 18,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            borderRadius: 12,
                            fontFamily: "Bai",
                            callback: () {
                              InitialQrPaymentDialog(
                                id: accountId,
                                callback: (String newAccount) {
                                  _changeAccount(newAccount);
                                },
                              ).dialog(context);
                            })))
              ],
            ),
          ),
          Expanded(child: _body(context, widget.peoples))
        ],
      ),
    );
  }

  Widget _body(BuildContext context, List<PeopleModel> peoples) {
    List<Widget> peoplesWidget = [
      _discount(context),
      ...peoples.map((people) => _card(context, people))
    ];
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        // primary: false,
        // shrinkWrap: false,
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 60, top: 10),
        itemBuilder: (context, position) => peoplesWidget[position],
        separatorBuilder: (BuildContext context, int index) => index > 0
            ? Container(
                width: 1,
                height: 1,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.only(bottom: 6),
              )
            : Container(
                height: 10,
              ),
        itemCount: peoplesWidget.length);
  }

  Widget _discount(BuildContext context) {
    return IgnorePointer(
      ignoring: voucher == null,
      child: MelonBouncingButton(
          callback: () {
            DiscountDialog(
              voucher: voucher,
              callback: (VoucherDiscountModel newVoucherDiscount) {
                voucher = newVoucherDiscount;
                if (widget.peoples.isNotEmpty) {
                  discountPerPerson = double.parse((((voucher?.cash?.value ?? 0.00) +
                      (voucher?.receipt?.value ?? 0.00)) /
                      widget.peoples.length).toStringAsFixed(2));
                }
                setState(() {});
              },
            ).dialog(context);
          },
          child: Container(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ส่วนลด",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Bai',
                          color: Colors.black),
                    ),
                    if (voucher != null)
                      const Text(
                        "แตะเพื่อแก้ไข",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Bai',
                            color: Colors.black),
                      ),
                    if (voucher == null)
                      const Text(
                        "ยอดรวมไม่สามารถใช้ส่วนลดได้",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Bai',
                            color: Colors.red),
                      ),
                  ],
                ),
                if (voucher?.cash != null || voucher?.receipt != null)
                  const SizedBox(height: 14),
                if (voucher?.cash != null)
                  _priceWidget("คูปองแทนเงินสด", voucher?.cash?.value ?? 0.00,
                      fontWeight: FontWeight.normal),
                if (voucher?.cash != null) const SizedBox(height: 2),
                if (voucher?.receipt != null)
                  _priceWidget(
                      "คูปองท้ายใบเสร็จ", voucher?.receipt?.value ?? 0.00,
                      fontWeight: FontWeight.normal),
                if (voucher?.receipt != null) const SizedBox(height: 10),
                if (voucher?.cash != null || voucher?.receipt != null)
                  _priceWidget(
                      "รวม",
                      (voucher?.cash?.value ?? 0.00) +
                          (voucher?.receipt?.value ?? 0.00),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
              ],
            ),
          )),
    );
  }

  Widget _card(BuildContext context, PeopleModel people) {
    return Container(
      width: size.resolve(context).width,
      //color: Colors.red,
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          people.name,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Bai',
              color: Colors.black),
        ),
        const SizedBox(height: 10),
        if (people.copper.value > 0) _plate("จานแดง", 40, people.copper.value),
        if (people.silver.value > 0) _plate("จานเงิน", 60, people.silver.value),
        if (people.gold.value > 0) _plate("จานทอง", 80, people.gold.value),
        if (people.black.value > 0) _plate("จานดำ", 120, people.black.value),
        ...people.plates
            .map((plate) => _plate(plate.name ?? "", plate.price, plate.value)),
        const SizedBox(height: 14),
        _priceWidget("ค่าเซอร์วิส",
            SushiroMainProvider.calculatePricing(people: people) * 0.1),
        const SizedBox(height: 2),
        if (discountPerPerson > 0.00)
          _priceWidget(
            "ส่วนลด",
            discountPerPerson,
          ),
        if (discountPerPerson > 0.00) const SizedBox(height: 2),
        _priceWidget(
            "รวม",
            SushiroMainProvider.calculatePricing(
                people: people, includeServiceCharge: true) - discountPerPerson,
            fontWeight: FontWeight.bold,
            fontSize: 16),
        if (accountId != null) const SizedBox(height: 10),
        if (accountId != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MelonBouncingButton(
                callback: () {
                  Container(
                    constraints: BoxConstraints(maxWidth: 360),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (accountId != null)
                          QRCodeGenerate(
                            promptPayId: accountId!,
                            amount: SushiroMainProvider.calculatePricing(people: people, includeServiceCharge: true) - discountPerPerson,
                            width: 400,
                            height: 400,
                            promptPayDetailCustom: Text(
                              "เลขบัญชี $accountId",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Bai',
                                  color: Colors.black),
                            ),
                            amountDetailCustom: Text(
                              "${(SushiroMainProvider.calculatePricing(people: people, includeServiceCharge: true) - discountPerPerson).toMoney} บาท",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Bai',
                                  color: Colors.black),
                            ),
                          ),

                        // Container(
                        //   child: Image.network(
                        //       "https://promptpay.io/$accountId/${SushiroMainProvider.calculatePricing(people: people, includeServiceCharge: true).ceil()}.png"),
                        // ),
                        SizedBox(height: 10),
                        // Text(
                        //   "${SushiroMainProvider.calculatePricing(people: people, includeServiceCharge: true).ceil().toStringAsFixed(2)} บาท",
                        //   style: TextStyle(
                        //       fontSize: 24,
                        //       fontWeight: FontWeight.bold,
                        //       fontFamily: 'Bai',
                        //       color: Colors.black),
                        // ),
                        // SizedBox(height: 6),
                        const Text(
                          "กรุณาเช็คชื่อบัญชีปลายทางและจำนวนเงินก่อนทำการโอนทุกครั้ง",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Bai',
                              color: Colors.red),
                        ),
                        SizedBox(height: 16),

                        MelonBouncingButton(
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
                                "ปิด",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Bai',
                                    color: Colors.black),
                              ),
                            ))
                      ],
                    ),
                  ).dialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black.withOpacity(0.05)),
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                  child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.qrcode,
                            color: Colors.black, size: 22),
                        SizedBox(width: 6),
                        Text(
                          "เปิดพร้อมเพย์ QR",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Bai',
                              color: Colors.black),
                        ),
                      ]),
                ),
              )
            ],
          ),
        const SizedBox(height: 2),
      ]),
    );
  }

  Widget _plate(String name, double price, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: 'Bai',
              color: Colors.black),
        ),
        Container(
          width: 80,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              value.toString(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Bai',
                  color: Colors.black),
            ),
            const Text(
              " x ",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Bai',
                  color: Colors.black),
            ),
            Text(
              price.toMoney,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Bai',
                  color: Colors.black),
            )
          ]),
        )
      ],
    );
  }

  Widget _priceWidget(String name, double price,
      {FontWeight fontWeight = FontWeight.normal, double fontSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: 'Bai',
              color: Colors.black),
        ),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              price.toMoney,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: 'Bai',
                  color: Colors.black),
            ),
            Text(
              " บาท",
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: 'Bai',
                  color: Colors.black),
            ),
          ]),
        )
      ],
    );
  }
}

WoltModalSheetPage summaryPage(
    BuildContext modalSheetContext, TextTheme textTheme,
    {required List<PeopleModel> peoples}) {
  final LayoutValue<Size> size = LayoutValue.builder((layout) {
    return Size(layout.width, layout.size.height);
  });

  return WoltModalSheetPage(
    hasSabGradient: false,
    forceMaxHeight: false,
    navBarHeight: 0,
    backgroundColor: const Color(0xFFFFB920),
    isTopBarLayerAlwaysVisible: false,
    child: SummaryPageDialog(
      peoples: peoples,
    ),
  );
}
