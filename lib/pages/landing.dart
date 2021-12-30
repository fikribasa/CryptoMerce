import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/account.dart';
import 'package:wartec_app/pages/tokenDetail.dart';
import 'package:wartec_app/pages/watchlist.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class LandingPage extends StatefulWidget {
  final AppContext? _ctx;
  LandingPage(AppContext? ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget coinCard(
      {String? coinIcon,
      String? title,
      String? subtitle,
      String? chart,
      String? price,
      String? change,
      bool showChart = false}) {
    return InkWell(
      onTap: () {
        Get.to(() => TokenDetailScreen());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        margin: const EdgeInsets.only(bottom: 6.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          children: [
            Expanded(flex: 1, child: Image.asset(coinIcon!)),
            SizedBox(width: 6.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title!, style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 6.0),
                  Text(
                    subtitle!,
                    style: TextStyle(
                        color: AppPalette.instance.grey10, fontSize: 12),
                    maxLines: 1,
                  )
                ],
              ),
            ),
            Expanded(flex: 2, child: Image.asset(chart!)),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 6.0),
                  Text(change!,
                      style: TextStyle(fontSize: 10.0, color: Colors.green))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget watchlistWidget(double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => WatchlistScreen(widget._ctx!));
            },
            child: Container(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Watchlist",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                SizedBox(width: 6.0),
                SvgPicture.asset('assets/icons/edit.svg'),
              ],
            )),
          ),
          SizedBox(height: 10),
          coinCard(
              coinIcon: "assets/icons/zaq.png",
              title: "ZAC",
              subtitle: "ZACoin",
              chart: "assets/images/chart.png",
              price: "Rp 77,199",
              change: "+9.77%",
              showChart: true),
          coinCard(
              coinIcon: "assets/icons/btc.png",
              title: "BTC",
              subtitle: "Bitcoin",
              chart: "assets/images/chart.png",
              price: "Rp 709,290,630",
              change: "+9.77%",
              showChart: true),
          coinCard(
              coinIcon: "assets/icons/eth.png",
              title: "ETH",
              subtitle: "Ethereum",
              chart: "assets/images/chart.png",
              price: "Rp 77,199",
              change: "+9.77%",
              showChart: true),
          coinCard(
              coinIcon: "assets/icons/dash.png",
              title: "GT",
              subtitle: "Dash",
              chart: "assets/images/chart.png",
              price: "Rp 77,199",
              change: "+9.77%",
              showChart: true),
        ],
      ),
    );
  }

  Widget trendingWidget(double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text("Trending",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
          SizedBox(height: 10),
          coinCard(
              coinIcon: "assets/icons/zaq.png",
              title: "ZAC",
              subtitle: "ZACoin",
              chart: "assets/images/chart.png",
              price: "Rp 77,199",
              change: "+9.77%",
              showChart: true),
          coinCard(
              coinIcon: "assets/icons/btc.png",
              title: "BTC",
              subtitle: "Bitcoin",
              chart: "assets/images/chart.png",
              price: "Rp 709,290,630",
              change: "+9.77%",
              showChart: true),
          coinCard(
              coinIcon: "assets/icons/eth.png",
              title: "ETH",
              subtitle: "Ethereum",
              chart: "assets/images/chart.png",
              price: "Rp 77,199",
              change: "+9.77%",
              showChart: true),
          coinCard(
              coinIcon: "assets/icons/dash.png",
              title: "GT",
              subtitle: "Dash",
              chart: "assets/images/chart.png",
              price: "Rp 77,199",
              change: "+9.77%",
              showChart: true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: AppPalette.instance.accent5,
                                borderRadius: BorderRadius.circular(30.0)),
                            alignment: Alignment.center,
                            child: Text(
                              "Wartec",
                              style: TextStyle(
                                  fontSize: 8.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text("Wartec",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 40.0,
                            height: 40,
                            decoration: BoxDecoration(
                                color: hexToColor("#FFF6EB"),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextButton(
                                onPressed: () {},
                                child:
                                    SvgPicture.asset('assets/icons/bell.svg')),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Get.to(() => AccountScreen());
                            },
                            child: Container(
                                width: 30.0,
                                child:
                                    Image.asset("assets/images/profile.png")),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Good Afternoon,",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                TextSpan(
                    text: " Mr. Rommy",
                    style: TextStyle(
                      color: AppPalette.instance.accent5,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    )),
              ])),
              SizedBox(height: 20.0),
              Text("Assets",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Container(
                width: _screenWidth,
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Container(child: Image.asset("assets/images/wc2.png")),
                    Container(child: Image.asset("assets/images/wc11.png")),
                    Container(child: Image.asset("assets/images/wc21.png")),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: _screenWidth,
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    watchlistWidget(_screenWidth),
                    trendingWidget(_screenWidth),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
