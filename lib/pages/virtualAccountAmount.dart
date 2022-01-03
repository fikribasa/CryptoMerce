import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/paymentConfirmation.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class VirtualAccountAmountScreen extends StatefulWidget {
  final AppContext? _ctx;

  VirtualAccountAmountScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _VirtualAccountAmountScreenState createState() =>
      _VirtualAccountAmountScreenState();
}

class _VirtualAccountAmountScreenState
    extends State<VirtualAccountAmountScreen> {
  final _controller = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Input deposit amount",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Selected Bank",
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/icons/bca.png', height: 24),
                                SizedBox(width: 12),
                                Text("Bank Central Asia"),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Change Bank",
                                  style: TextStyle(
                                      color: AppPalette.instance.primary200,
                                      fontSize: 10),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
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
                      color: Colors.white,
                      width: _screenWidth * 0.9,
                      child: PrimaryButton(
                        label: "Continue Transaction",
                        onPressed: () {
                          Get.to(() => PaymentConfirmationScreen(widget._ctx!));
                        },
                      ))
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
