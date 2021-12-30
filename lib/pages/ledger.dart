import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class LedgerScreen extends StatefulWidget {
  final AppContext _ctx;
  LedgerScreen(AppContext ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _LedgerScreenState createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  bool isCurrencyUSD = true;

  Widget selectedCurrency(String curr) {
    return InkWell(
      onTap: () {
        this.setState(() {
          isCurrencyUSD = !isCurrencyUSD;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        child: Text(
          curr,
          style: TextStyle(color: Colors.white, fontSize: 11.0),
        ),
        decoration: BoxDecoration(
            color: AppPalette.instance.brown,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }

  Widget unselectedCurr(String curr) {
    return InkWell(
      onTap: () {
        this.setState(() {
          isCurrencyUSD = !isCurrencyUSD;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        child: Text(
          curr,
          style: TextStyle(color: AppPalette.instance.brown, fontSize: 11.0),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(
              4.0,
            )),
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
                      Text("Ledger",
                          style: AppPalette.instance.textStyleAppBar),
                      Container(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset("assets/icons/list.svg"),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "History",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: AppPalette.instance.primary200),
                              ),
                            ],
                          ))
                    ],
                  )),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isCurrencyUSD
                        ? unselectedCurr("IDR")
                        : selectedCurrency("IDR"),
                    isCurrencyUSD
                        ? selectedCurrency("USD")
                        : unselectedCurr("USD"),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                  child: Image.asset(
                "assets/images/ledgermain.png",
                fit: BoxFit.fill,
              )),
              SizedBox(height: 20.0),
              Container(
                width: _screenWidth,
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Container(child: Image.asset("assets/images/wc21.png")),
                    Container(child: Image.asset("assets/images/wc11.png")),
                    Container(child: Image.asset("assets/images/wc2.png")),
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
