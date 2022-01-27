import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class WatchlistScreen extends StatefulWidget {
  final AppContext _ctx;
  WatchlistScreen(AppContext ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final TextEditingController _controller = new TextEditingController();

  Widget coinCard(
      {String? coinIcon,
      String? title,
      String? subtitle,
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
                        color: _chgColor
                            ? hexToColor("#BF2121")
                            : AppPalette.instance.success400))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4.0),
            width: 40.0,
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Wachlist",
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
            color: Colors.black54,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.0),
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
