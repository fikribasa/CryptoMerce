import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
        SvgPicture.asset('assets/icons/star-fill.svg'),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 90),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: Image.asset(
                  widget.item!.image!,
                  width: 60,
                )),
                SizedBox(height: 10),
                Text("Estimated Buy Price"),
                SizedBox(height: 10),
                Text(
                  "${widget.item!.tokenPriceIDR}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "1 ${widget.item!.code}",
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.black12, thickness: 1.0),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 1, child: Text("")),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Text("Your Rupiah Balance"),
                          SizedBox(height: 6),
                          Text("Rp 9,000,000",
                              style: TextStyle(
                                  color: hexToColor("#4541B9"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: Text("Use \$")),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                    color: Colors.black12,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 100,
                                  child: CustomTextField(
                                    controller: _controller,
                                    onChange: numberCount,
                                  )),
                              Text(
                                "RP",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: SvgPicture.asset('assets/icons/swap.svg'),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 12),
                              Container(
                                  alignment: Alignment.centerRight,
                                  width: 100,
                                  child: Text(_controller2.text,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppPalette.instance.primary09,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700))),
                              SizedBox(height: 12),
                              Text(
                                widget.item!.code ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          color: Colors.white,
          width: _screenWidth * 0.7,
          child: PrimaryButton(
              label: "Buy",
              onPressed: () {
                Get.to(() => PaymentMethodScreen(widget._ctx!,
                    item: widget.item!, balance: _controller.text));
              })),
    );
  }
}
