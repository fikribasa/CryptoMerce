import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/virtualAccountAmount.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class VirtualAccountScreen extends StatefulWidget {
  final AppContext? _ctx;

  VirtualAccountScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _VirtualAccountScreeenStae createState() => _VirtualAccountScreeenStae();
}

class _VirtualAccountScreeenStae extends State<VirtualAccountScreen> {
  late double _screenWidth;
  // define type of payment methode
  int payMethod = 1;
  List<String> paymentTexts = [
    'BCA',
    'HSBC Bank',
    'Bank Nasional Indonesia (BNI)',
  ];
  List<String> imageAsset = [
    'assets/icons/bca.png',
    'assets/icons/hsbc.png',
    'assets/icons/bni.png',
  ];
  handlePayMethodChange(dynamic value) {
    return setState(() {
      this.payMethod = value;
    });
  }

  get _getAppbar {
    return new AppBar(
      title: Text("Virtual Account",
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

  Widget radioBuilder(String _title, int _value) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(imageAsset[_value - 1]),
                    SizedBox(width: 12),
                    Text(_title),
                  ],
                ),
                Radio(
                    activeColor: Colors.blue,
                    value: _value,
                    groupValue: this.payMethod,
                    onChanged: this.handlePayMethodChange),
              ],
            ),
          ),
          Divider(color: Colors.black12, thickness: 1.0)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Deposit via Virtual Account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              Text("Available Bank",
                  style: TextStyle(fontSize: 12, color: Colors.black45)),
              radioBuilder(paymentTexts[0], 1),
              radioBuilder(paymentTexts[1], 2),
              radioBuilder(paymentTexts[2], 3),
              SizedBox(height: 40),
            ],
          ),
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: _screenWidth * 0.5,
        child: PrimaryButton(
          label: "ADD AMOUNT",
          onPressed: () {
            Get.to(() => VirtualAccountAmountScreen(widget._ctx!));
          },
        ),
      ),
    );
  }
}
