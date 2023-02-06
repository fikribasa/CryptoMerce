import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/banks.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class BankAccountsScreen extends StatefulWidget {
  final AppContext? _ctx;
  BankAccountsScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _BankAccountsScreenState createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  final _controller = TextEditingController(text: "0");
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
    if (_num != null && _num != "0") {
      _db = (double.tryParse(_num) ?? 0).toStringAsFixed(3);
    }
    this.setState(() {
      _controller.text = _db;
    });
  }

  get _getAppbar {
    return new AppBar(
        title: Text("Bank Accounts",
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
                Container(child: SvgPicture.asset("assets/icons/trash.svg")),
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
                    Get.to(() => ListBankScreen(widget._ctx));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
