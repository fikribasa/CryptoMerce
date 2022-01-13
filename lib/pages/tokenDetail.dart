import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
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
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: _screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item!.code} Price",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "IDR",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black26),
                            ),
                            Text(
                              "${item!.tokenPriceIDR}",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text("${item!.change}%",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppPalette.instance.success400)),
                          ],
                        ),
                        Container(
                            child: Image.asset(
                          item!.image!,
                          width: 60,
                          height: 60,
                        )),
                      ],
                    )),
                SizedBox(height: 20.0),
                Container(child: Image.asset("assets/images/price-graph.png")),
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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                ),
                SizedBox(height: 20.0),
                Text("About ${item!.code}",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 16.0),
                Text(item!.headline ?? ""),
                Text(item!.detail ?? ""),
                Container(
                    width: _screenWidth,
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Visit Official Website"),
                    )),
                Text("Market Statistics",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Container(
                    width: _screenWidth,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Market Capitalization",
                            style: TextStyle(color: AppPalette.instance.grey10),
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
                            style: TextStyle(color: AppPalette.instance.grey10),
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
                            style: TextStyle(color: AppPalette.instance.grey10),
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
                            style: TextStyle(color: AppPalette.instance.grey10),
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
                            style: TextStyle(color: AppPalette.instance.grey10),
                          ),
                          Text(
                            item!.volumeDay ?? "",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ])),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
        width: _screenWidth,
        height: 80,
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
                      width: double.infinity,
                      child: PrimaryButton(label: "Sell", onPressed: null)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
