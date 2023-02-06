import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/paymentConfirmation.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class PaymentMethodScreen extends StatelessWidget {
  final AppContext? _ctx;

  TokenItem? item;
  String? balance;
  PaymentMethodScreen(this._ctx, {Key? key, this.item, this.balance})
      : super(key: key);

  final Map<String, String> _paymentMethodWallet = {
    "GoPay": 'assets/icons/gopay.svg',
    "Dana": 'assets/icons/dana.svg',
    "OVO": 'assets/icons/ovo.svg',
    "LinkAja": 'assets/icons/linkaja.svg',
    "ShopeePay": 'assets/icons/shopeepay.svg',
  };

  final Map<String, String> _paymentMethodBank = {
    "Bank Central Asia": 'assets/icons/bca.svg',
    "HSBC Bank": 'assets/icons/hsbc.svg',
    "Bank Nasional Indonesia (BNI)": 'assets/icons/bni.svg',
  };
  get _getAppbar {
    return new AppBar(
      title: Text("Add Fund From",
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

  Widget paymentBox(String title, String image) {
    return InkWell(
      onTap: () {
        Get.to(() => PaymentConfirmationScreen(
              this._ctx,
              item: this.item!,
              balance: this.balance!,
              paymentMethod: title,
              image: image,
              type: "ewallet",
            ));
        // type can be bank va or ewallet
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  child: SvgPicture.asset(
                    image,
                    width: 30,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                      color: AppPalette.instance.grey10,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }

  Widget subTitle(String title, double _screenWidth) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      width: _screenWidth,
      child: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              subTitle("Virtual Account", _screenWidth),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: _paymentMethodBank.length,
                itemBuilder: (_, int index) {
                  String key = _paymentMethodBank.keys.elementAt(index);
                  return paymentBox(key, _paymentMethodBank[key]!);
                },
              ),
              subTitle("Bank Transfer", _screenWidth),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: _paymentMethodBank.length,
                itemBuilder: (_, int index) {
                  String key = _paymentMethodBank.keys.elementAt(index);
                  return paymentBox(key, _paymentMethodBank[key]!);
                },
              ),
              subTitle("E-Wallet", _screenWidth),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: _paymentMethodWallet.length,
                itemBuilder: (_, int index) {
                  String key = _paymentMethodWallet.keys.elementAt(index);
                  return paymentBox(key, _paymentMethodWallet[key]!);
                },
              ),
              SizedBox(height: 60),
            ],
          ),
        )),
      ),
    );
  }
}
