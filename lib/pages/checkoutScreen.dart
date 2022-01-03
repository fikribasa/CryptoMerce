import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/loadingVerification.dart';
import 'package:wartec_app/pages/transaction.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/numberFormatter.dart';

class CheckoutScreen extends StatefulWidget {
  String? totalAmount;
  final AppContext? _ctx;

  CheckoutScreen(this._ctx, {Key? key, this.totalAmount}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final timerStyle = TextStyle(
      color: AppPalette.instance.downtrend,
      fontSize: 16,
      fontWeight: FontWeight.w600);
  get _getAppbar {
    return new AppBar(
      title: Text("Check Out",
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

  Widget _timerItem(String _time, String _context) {
    return Column(
      children: [
        Text(_time, style: timerStyle),
        SizedBox(height: 6),
        Text(_context, style: timerStyle)
      ],
    );
  }

  Widget _divider() {
    return Column(
      children: [
        SizedBox(width: 6),
        Text(":"),
        SizedBox(height: 6),
        Text(""),
        SizedBox(width: 6),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: TextStyle(color: AppPalette.instance.primary200)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget openButton = TextButton(
      child:
          Text("Open", style: TextStyle(color: AppPalette.instance.primary200)),
      onPressed: () {
        Get.to(() => LoadingVerificationScreen(widget._ctx!));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("AlertDialog"),
      content: Text("Open in \"Gojek\"?"),
      actions: [
        cancelButton,
        openButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: _screenWidth,
                  decoration: BoxDecoration(
                      color: hexToColor("#f5f3ef"),
                      border: Border.all(width: 1.0, color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Payment Method",
                              style: TextStyle(fontSize: 12)),
                          SizedBox(height: 8),
                          Image.asset('assets/icons/gopay.png', height: 24),
                          SizedBox(height: 16),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: _screenWidth,
                          child: Text("Total Amount",
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 12),
                      Container(
                        width: _screenWidth,
                        child: Text("Rp ${widget.totalAmount ?? 0}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: hexToColor("#086F59")),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.black12, thickness: 1.0),
                      SizedBox(height: 20),
                      Container(
                          width: _screenWidth,
                          child: Text("Transaction Limit",
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 10),
                      Container(
                        width: _screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _timerItem("00", "hrs"),
                            _divider(),
                            _timerItem("14", "min"),
                            _divider(),
                            _timerItem("59", "sec"),
                          ],
                        ),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          width: _screenWidth,
          height: 120,
          child: Column(
            children: [
              Container(
                width: _screenWidth,
                child: PrimaryButton(
                  label: "Pay Now",
                  onPressed: () {
                    showAlertDialog(context);
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
                          style: AppPalette.instance.textStylePrimary)))
            ],
          )),
    );
  }
}
