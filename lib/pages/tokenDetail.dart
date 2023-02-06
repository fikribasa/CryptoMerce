import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/buyToken.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class TokenDetailScreen extends StatelessWidget {
  final AppContext? _ctx;

  final TokenItem? item;
  const TokenDetailScreen(this._ctx, this.item, {Key? key}) : super(key: key);
  get _getAppbar {
    return new AppBar(
      title: Text(item!.code ?? "",
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
        SvgPicture.asset('assets/icons/star-fill.svg'),
        SizedBox(width: 10),
        Icon(
          Icons.info_outline,
          size: 24,
          color: AppPalette.instance.grey10,
        ),
        SizedBox(width: 16)
      ],
    );
  }

  Widget timeframeSelected(String title) {
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
            color: AppPalette.instance.accent5,
            borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)));
  }

  Widget timeframeNotSelected(String title) {
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 16),
                  color: Colors.white,
                  width: _screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Image.asset(
                        item!.image!,
                        width: 60,
                        height: 60,
                      )),
                      SizedBox(height: 10),
                      Text(
                        "IDR ${item!.tokenPriceIDR}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${item!.code} Price  ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppPalette.instance.natural04),
                          ),
                          SvgPicture.asset('assets/icons/up.svg'),
                          Text("  ${item!.change}%",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppPalette.instance.success400)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    color: Colors.white,
                    child: Image.asset("assets/images/price-graph.png")),
                Container(
                  child: Row(
                    children: [
                      timeframeSelected("1H"),
                      timeframeNotSelected("1D"),
                      timeframeNotSelected("W"),
                      timeframeNotSelected("M"),
                      timeframeNotSelected("Y"),
                      timeframeNotSelected("ALL")
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  margin: const EdgeInsets.only(bottom: 6.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Asset",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  child: Image.asset(
                                item!.image!,
                                width: 40.0,
                              )),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                item!.code!,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("480.79 ${item!.code}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(
                                "IDR 37,117,000",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  margin: const EdgeInsets.only(bottom: 6.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("About ${item!.code}",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16.0),
                        Text(item!.headline ?? ""),
                        Text(item!.detail ?? ""),
                        SizedBox(height: 10),
                        PrimaryOutline(
                          label: "Visit Official Website",
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                      ]),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  margin: const EdgeInsets.only(bottom: 6.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Market Statistics",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Container(
                          width: _screenWidth,
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Market Capitalization",
                                  style: TextStyle(
                                      color: AppPalette.instance.grey10),
                                ),
                                Text(
                                  item!.capitalization ?? "",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              ])),
                      Container(
                          width: _screenWidth,
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fully Diluted Valuation",
                                  style: TextStyle(
                                      color: AppPalette.instance.grey10),
                                ),
                                Text(
                                  item!.valuation ?? "",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              ])),
                      Container(
                          width: _screenWidth,
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Circulating Supply",
                                  style: TextStyle(
                                      color: AppPalette.instance.grey10),
                                ),
                                Text(
                                  item!.supply ?? "",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              ])),
                      Container(
                          width: _screenWidth,
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Maximum Supply",
                                  style: TextStyle(
                                      color: AppPalette.instance.grey10),
                                ),
                                Text(
                                  item!.maxSupply ?? "",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              ])),
                      Container(
                          width: _screenWidth,
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Global Volume (24 Hours)",
                                  style: TextStyle(
                                      color: AppPalette.instance.grey10),
                                ),
                                Text(
                                  item!.volumeDay ?? "",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              ])),
                    ],
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
        color: Colors.white,
        width: _screenWidth,
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "Rp ${item!.tokenPriceIDR}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      width: double.infinity,
                      child: PrimaryButton(
                          label: "Buy",
                          onPressed: () {
                            Get.to(() => BuyTokenScreen(this._ctx!, item!));
                          })),
                ],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "Rp ${item!.tokenPriceIDR}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 8),
                      width: double.infinity,
                      child: PrimaryOutline(label: "Sell", onPressed: null)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
