import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/customTextField.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/paymentMethod.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class BuyTokenScreen extends StatefulWidget {
  final AppContext? _ctx;
  TokenItem? item;
  BuyTokenScreen(this._ctx, this.item, {Key? key}) : super(key: key);

  @override
  _BuyTokenScreenState createState() => _BuyTokenScreenState();
}

class _BuyTokenScreenState extends State<BuyTokenScreen> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController(text: "0");

  numberCount(String _num) {
    var _db = "0";
    if (_num != null && _num != "0") {
      _db = ((double.tryParse(_num) ?? 0) / widget.item!.price!)
          .toStringAsFixed(3);
    }
    this.setState(() {
      _controller2.text = _db;
    });
  }

  get _getAppbar {
    return new AppBar(
      title: Text("Buy ${widget.item!.code}",
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
        SvgPicture.asset('assets/icons/star.svg'),
        SizedBox(width: 10),
        SvgPicture.asset("assets/icons/icon.svg"),
        SizedBox(width: 16)
      ],
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Column(
                    children: [
                      Container(
                          child: Image.asset(
                        widget.item!.image!,
                        width: 60,
                      )),
                      SizedBox(height: 10),
                      Text("Estimated Buy Price"),
                      SizedBox(height: 6),
                      Text(
                        "${widget.item!.tokenPriceIDR}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "1 ${widget.item!.code}",
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(
                                      "TOTAL",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54),
                                    ),
                                    Container(
                                        width: 100,
                                        child: CustomTextField(
                                          controller: _controller,
                                          onChange: numberCount,
                                        )),
                                  ])),
                              CurrencyDropDownWidget()
                            ]),
                        Divider(color: Colors.black12, thickness: 1.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(
                                      "BUY",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54),
                                    ),
                                    Container(
                                        width: 100,
                                        child: CustomTextField(
                                          controller: _controller2,
                                          onChange: numberCount,
                                        )),
                                  ])),
                              CoinDropDownWidget()
                            ]),
                      ],
                    )),
                SizedBox(height: 80)
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
                    label: "Buy",
                    onPressed: () {
                      Get.to(() => PaymentMethodScreen(widget._ctx!,
                          item: widget.item!, balance: _controller.text));
                    }),
              ),
            ],
          )),
    );
  }
}

class CurrencyDropDownWidget extends StatefulWidget {
  const CurrencyDropDownWidget({Key? key}) : super(key: key);

  @override
  State<CurrencyDropDownWidget> createState() => _CurrencyDropDownWidgetState();
}

class _CurrencyDropDownWidgetState extends State<CurrencyDropDownWidget> {
  String dropdownValue = 'Rp';

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: AppPalette.instance.accent5),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, top: 4, bottom: 4),
        child: DropdownButton<String>(
          isDense: true,
          value: dropdownValue,
          underline: Container(height: 0),
          icon: Icon(
            Icons.expand_more,
            color: AppPalette.instance.accent5,
          ),
          elevation: 16,
          style: TextStyle(
              color: AppPalette.instance.accent5, fontWeight: FontWeight.w400),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Rp', 'USD']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CoinDropDownWidget extends StatefulWidget {
  const CoinDropDownWidget({Key? key}) : super(key: key);

  @override
  State<CoinDropDownWidget> createState() => _CoinDropDownWidgetState();
}

class _CoinDropDownWidgetState extends State<CoinDropDownWidget> {
  String dropdownValue = 'ZAC';

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: AppPalette.instance.accent5),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, top: 4, bottom: 4),
        child: DropdownButton<String>(
          isDense: true,
          value: dropdownValue,
          underline: Container(height: 0),
          icon: Icon(
            Icons.expand_more,
            color: AppPalette.instance.accent5,
          ),
          elevation: 16,
          style: TextStyle(
              color: AppPalette.instance.accent5, fontWeight: FontWeight.w400),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['ZAC', 'USD']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
