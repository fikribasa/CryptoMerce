import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/paymentConfirmation.dart';
import 'package:wartec_app/pages/pinVerification.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class PaymentMethodScreen extends StatelessWidget {
  final AppContext? _ctx;

  TokenItem? item;
  String? balance;
  PaymentMethodScreen(this._ctx, {Key? key, this.item, this.balance})
      : super(key: key);
  final _paymentMethod = [
    "GoPay",
    "Virtual Account",
    "Transfer Bank",
    "ShopeePay",
    "OVO",
    "Dana",
    "LinkAja"
  ];
  get _getAppbar {
    return new AppBar(
      title: Text("Add Fund From",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: new InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: new Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onTap: () {
          Get.back();
        },
      ),
      centerTitle: true,
      actions: [
        Icon(
          Icons.info_outline,
          size: 24,
          color: AppPalette.instance.grey10,
        ),
        SizedBox(width: 16)
      ],
    );
  }

  Widget paymentBox(String title) {
    return InkWell(
      onTap: () {
        Get.to(() => PaymentConfirmationScreen(this._ctx,
            item: this.item!, balance: this.balance!, paymentMethod: title));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppPalette.instance.grey10,
                  fontWeight: FontWeight.w700),
            ),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: _paymentMethod.length,
                itemBuilder: (_, int index) {
                  return paymentBox(_paymentMethod[index]);
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
