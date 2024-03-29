import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/bankAccounts.dart';
import 'package:wartec_app/pages/idrWithdrawConfirmation.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class IDRWithdrawScreen extends StatefulWidget {
  final AppContext? _ctx;
  IDRWithdrawScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _IDRWithdrawScreenState createState() => _IDRWithdrawScreenState();
}

class _IDRWithdrawScreenState extends State<IDRWithdrawScreen> {
  final _controller = TextEditingController();
  // define type of payment methode
  int payMethod = 1;
  List<String> paymentTexts = [
    'BCA \u2022 1453 9194 84',
    'HSBC \u2022 2707 5060 4',
    'BNI \u2022 4952 9200 347',
  ];
  List<String> imageAsset = [
    'assets/icons/bca.svg',
    'assets/icons/hsbc.svg',
    'assets/icons/bni.svg',
  ];

  handlePayMethodChange(dynamic value) {
    return setState(() {
      this.payMethod = value;
    });
  }

  numberCount(String _num) {
    var _db = "0";
    if (_num != "0") {
      _db = (double.tryParse(_num) ?? 0).toStringAsFixed(3);
    }
    this.setState(() {
      _controller.text = _db;
    });
  }

  get _getAppbar {
    return new AppBar(
        title: Text("Rupiah Withdrawal",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
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
        centerTitle: true);
  }

  Widget radioBuilder(String _title, int _value) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.only(bottom: 6),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(imageAsset[_value - 1]),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rommy Putra"),
                        Text(
                          _title,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppPalette.instance.neutral05),
                        ),
                      ],
                    ),
                  ],
                ),
                Radio(
                    activeColor: AppPalette.instance.accent5,
                    value: _value,
                    groupValue: this.payMethod,
                    onChanged: this.handlePayMethodChange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 90),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: _screenWidth,
                  child: Text("Your Bank Account",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                SizedBox(width: 20),
                Container(
                    width: _screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Column(
                      children: [
                        radioBuilder(paymentTexts[0], 1),
                        radioBuilder(paymentTexts[1], 2),
                        radioBuilder(paymentTexts[2], 3),
                      ],
                    )),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.to(() => BankAccountsScreen(widget._ctx));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Text("Add a bank account",
                        style: TextStyle(
                            color: AppPalette.instance.accent5, fontSize: 16)),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: _screenWidth * 0.9,
                        child: TextFormField(
                            autofocus: true,
                            textAlign: TextAlign.right,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: _controller,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[\\.|\\,|0-9]')),
                            ],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              prefix: Text("Rp"),
                              hintText: "0",
                            ))),
                    Container(
                        width: _screenWidth * 0.9,
                        child: Text("Minimum withdrawal is Rp 50,000",
                            style: TextStyle(
                                color: AppPalette.instance.neutral05,
                                fontSize: 12)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          color: Colors.white,
          width: _screenWidth,
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Rupiah Balance"),
                  SizedBox(height: 6),
                  Text("Rp 9,000,000",
                      style: TextStyle(
                          color: AppPalette.instance.accent5,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                width: _screenWidth,
                child: PrimaryButton(
                    label: "Continue",
                    onPressed: () {
                      _controller.text.length > 0
                          ? Get.to(() => IDRWithdrawConfirmationScreen(
                              widget._ctx,
                              balance: int.tryParse(_controller.text),
                              image: imageAsset[payMethod - 1],
                              paymentMethod: paymentTexts[payMethod - 1]))
                          : Get.snackbar("Terjadi kesalahan",
                              "Mohon isi nominal withdraw terlebih dulu");
                    }),
              ),
            ],
          )),
    );
  }
}
