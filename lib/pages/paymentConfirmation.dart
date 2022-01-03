import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/checkoutScreen.dart';
import 'package:wartec_app/pages/transaction.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/numberFormatter.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  final AppContext? _ctx;

  TokenItem? item;
  String? balance;
  String? paymentMethod;
  PaymentConfirmationScreen(this._ctx,
      {Key? key, this.item, this.balance, this.paymentMethod})
      : super(key: key);

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  get _getAppbar {
    return new AppBar(
      title: Text("Confirmation",
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

  Widget confrmationVA(double _screenWidth) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: hexToColor("#f5f3ef"),
                border: Border.all(width: 1.0, color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  width: _screenWidth,
                  child: Text(
                    "Confirm Your Deposit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                    width: _screenWidth,
                    child: Text("Deposit Rupiah",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center)),
                SizedBox(height: 12),
                Container(
                  width: _screenWidth,
                  child: Text("Rp 1,000,000",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment Method", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("Virtual Account 1911085246562277",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Destination Account", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("User VA",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Transaction Fee", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("Rp 7,199",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 24),
                    Container(
                      width: _screenWidth,
                      child: Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Total  ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                          TextSpan(
                              text: "Rp 1,007,199",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                        ])),
                      ),
                    ),
                    SizedBox(height: 30),
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
                Get.to(() => TransactionScreen());
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

  Widget confrmationGoPay(double _screenWidth) {
    final _tokenGet =
        ((double.tryParse(widget.balance!) ?? 0) / widget.item!.price!)
            .toStringAsFixed(5);
    final _totalAmount =
        ((double.tryParse(widget.balance!) ?? 0) + 7000).toCurrencyFormat();
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: hexToColor("#f5f3ef"),
                border: Border.all(width: 1.0, color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  width: _screenWidth,
                  child: Text(
                    "Confirm Your Transaction",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                    width: _screenWidth,
                    child: Text("You are buying",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center)),
                SizedBox(height: 12),
                Container(
                  width: _screenWidth,
                  child: Text("${_tokenGet} ${widget.item!.code}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 10),
                Container(
                  width: _screenWidth,
                  child: Text(
                      "Rp ${(double.tryParse(widget.balance!) ?? 0).toCurrencyFormat()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: hexToColor("#086F59")),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment Method", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("GOPAY",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("You Will Get", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("${_tokenGet} ${widget.item!.code}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Destination Account", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("${widget.item!.code} Wallet",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Transaction Fee", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("Rp 7,000",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 24),
                    Container(
                      width: _screenWidth,
                      child: Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Amount  ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                          TextSpan(
                              text: "Rp ${_totalAmount}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                        ])),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "*Double check information above. We are not responsible for any misinformation.",
                style:
                    TextStyle(fontSize: 12, color: AppPalette.instance.grey10),
              ),
              Text(
                "*Transaction will be proceed in real time.",
                style:
                    TextStyle(fontSize: 12, color: AppPalette.instance.grey10),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: _screenWidth,
            child: PrimaryButton(
              label: "CONFIRM",
              onPressed: () {
                Get.to(() =>
                    CheckoutScreen(widget._ctx!, totalAmount: _totalAmount));
              },
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: widget.paymentMethod == "GoPay"
              ? confrmationGoPay(_screenWidth)
              : confrmationVA(_screenWidth)),
    );
  }
}
