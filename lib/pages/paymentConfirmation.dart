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
  String? image;
  String? type;
  PaymentConfirmationScreen(this._ctx,
      {Key? key,
      this.item,
      this.balance,
      this.paymentMethod,
      this.image,
      this.type})
      : super(key: key);

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  int vaFee = 7199;
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
                    child: Text("Deposit",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center)),
                SizedBox(height: 12),
                Container(
                  width: _screenWidth,
                  child: Text(
                      "Rp ${(double.tryParse(widget.balance!) ?? 0).toCurrencyFormat()}",
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
                    Text("Payment Method", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("${widget.paymentMethod ?? " "} Virtual Account",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Destination Account", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("Rupiah Wallet",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Transaction Fee", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text(
                        "Rp ${(double.tryParse(vaFee.toString()))?.toCurrencyFormat()}",
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
                            Text(
                                "Rp  ${((double.tryParse(widget.balance!) ?? 0) + vaFee).toCurrencyFormat()}",
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

  Widget confrmationEwallet(double _screenWidth) {
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
                    child: Text("You are buying",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center)),
                SizedBox(height: 8),
                Container(
                  width: _screenWidth,
                  child: Text("${_tokenGet} ${widget.item!.code}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 8),
                Container(
                  width: _screenWidth,
                  child: Text(
                      "Rp ${(double.tryParse(widget.balance!) ?? 0).toCurrencyFormat()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.instance.primary09),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment Method", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text(widget.paymentMethod ?? "",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("Destination Account", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("${widget.item!.code} Wallet",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 16),
                    Text("You Will Get", style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Text("${_tokenGet} ${widget.item!.code}",
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
                            Text("Rp ${_totalAmount}",
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
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                color: AppPalette.instance.white,
                border: Border.all(
                  color: AppPalette.instance.accent5,
                ),
                borderRadius: BorderRadius.circular(8.0)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "*Double check information above. We are not responsible for any misinformation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12, color: AppPalette.instance.grey10),
                ),
                Text(
                  "*Transaction will be proceed in real time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12, color: AppPalette.instance.grey10),
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
                Get.to(() => CheckoutScreen(widget._ctx!,
                    totalAmount: _totalAmount,
                    paymentMethod: widget.paymentMethod,
                    image: widget.image));
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
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: widget.type == "ewallet"
              ? confrmationEwallet(_screenWidth)
              : confrmationVA(_screenWidth)),
    );
  }
}
