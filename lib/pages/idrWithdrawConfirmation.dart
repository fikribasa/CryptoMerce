import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/checkoutScreen.dart';
import 'package:wartec_app/pages/transaction.dart';
import 'package:wartec_app/pages/withdrawLoading.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/numberFormatter.dart';

class IDRWithdrawConfirmationScreen extends StatefulWidget {
  final AppContext? _ctx;

  int? balance;
  String? paymentMethod;
  String? image;
  IDRWithdrawConfirmationScreen(this._ctx,
      {Key? key, this.balance, this.paymentMethod, this.image})
      : super(key: key);

  @override
  _IDRWithdrawConfirmationScreenState createState() =>
      _IDRWithdrawConfirmationScreenState();
}

class _IDRWithdrawConfirmationScreenState
    extends State<IDRWithdrawConfirmationScreen> {
  int fee = 5000;

  String toFixed(int? _num) {
    var ret = "0";
    ret = (double.tryParse(_num!.toString()))!.toCurrencyFormat();
    return ret;
  }

  get _getAppbar {
    return new AppBar(
      title: Text("Confirmation",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
      backgroundColor: Colors.white,
      elevation: 1.0,
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

  Widget confrmationVA(double _screenWidth) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: _screenWidth,
                    child: Image.asset('assets/icons/logomark-wartec.png',
                        height: 40)),
                Container(
                  width: _screenWidth,
                  child: Text(
                    "Confirm Your Transaction",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                    width: _screenWidth,
                    child: Text("You are withdrawing",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center)),
                SizedBox(height: 12),
                Container(
                  width: _screenWidth,
                  child: Text("Rp ${toFixed(widget.balance)}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 12),
                Divider(color: Colors.black12, thickness: 1.0),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Transfer to", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("BCA Virtual Account",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Transaction Fee", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("Rp ${toFixed(fee)}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 24),
                    Container(
                      width: _screenWidth,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppPalette.instance.natural10,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Transfer Amount",
                                style: TextStyle(fontSize: 12)),
                            SizedBox(height: 8),
                            Text("Rp ${toFixed(widget.balance! + fee)}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppPalette.instance.primary09)),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: _screenWidth,
            child: PrimaryButton(
              label: "CONFIRM",
              onPressed: () {
                Get.to(() => WithdrawLoadingScreen(widget._ctx));
              },
            ),
          ),
          Container(
            width: _screenWidth,
            child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel Transaction",
                    style: AppPalette.instance.textStylePrimary)),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: confrmationVA(_screenWidth)),
    );
  }
}
