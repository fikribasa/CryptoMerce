import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class MarketScreen extends StatefulWidget {
  final AppContext _ctx;
  MarketScreen(AppContext ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final TextEditingController _controller = new TextEditingController();

  Widget coinCard(
      {String? coinIcon,
      String? title,
      String? subtitle,
      String? chart,
      String? price,
      String? change,
      bool showChart = false}) {
    final _chgColor = change![0] == "-";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(coinIcon!))),
          SizedBox(width: 6.0),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title!, style: TextStyle(fontSize: 16.0)),
                SizedBox(height: 6.0),
                Text(subtitle!,
                    style: TextStyle(color: AppPalette.instance.grey10))
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price!, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 6.0),
                Text(change,
                    style: TextStyle(
                        fontSize: 12.0,
                        color:
                            _chgColor ? hexToColor("#BF2121") : Colors.green))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      Text("Market",
                          style: AppPalette.instance.textStyleAppBar),
                      Container(
                          padding: EdgeInsets.all(12.0),
                          child: SvgPicture.asset("assets/icons/icon.svg"))
                    ],
                  )),
              SizedBox(height: 20.0),
              Container(
                width: _screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: _screenWidth * 0.75,
                      decoration: BoxDecoration(
                        color: AppPalette.instance.grey05,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: _controller,
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.black38),
                            hintText: "Search",
                            hintStyle: new TextStyle(color: Colors.black38)),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: AppPalette.instance.grey05,
                            borderRadius: BorderRadius.circular(6)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        child: SvgPicture.asset("assets/icons/sort.svg"))
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              coinCard(
                  coinIcon: "assets/icons/zaq.png",
                  title: "ZACoin",
                  subtitle: "ZAC",
                  price: "Rp 77,199",
                  change: "+9.77%"),
              coinCard(
                  coinIcon: "assets/icons/btc.png",
                  title: "Bitcoin",
                  subtitle: "BTC",
                  price: "Rp 709,290,630",
                  change: "-3.02%"),
              coinCard(
                  coinIcon: "assets/icons/eth.png",
                  title: "Ethereum",
                  subtitle: "ETH",
                  price: "Rp 61,246,164",
                  change: "+9.77%"),
              coinCard(
                  coinIcon: "assets/icons/dash.png",
                  title: "DASH",
                  subtitle: "DASH",
                  price: "Rp 1,979,877",
                  change: "+9.77%"),
            ],
          ),
        )),
      ),
    );
  }
}
