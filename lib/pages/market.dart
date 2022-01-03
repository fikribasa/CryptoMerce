import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/components/signout.dart';
import 'package:wartec_app/pages/ledger.dart';
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
  bool _loser = false;
  bool _isRadioSelected = false;
  bool isCurrencyUSD = true;
  final _goto = [
    "Hide Coin",
    "Watchlist",
    "Account",
    "My Wallet",
  ];
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

  Widget paymentBox(String title) {
    return InkWell(
      onTap: () {
        Get.to(() => LedgerScreen(widget._ctx));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppPalette.instance.grey10,
                  fontWeight: FontWeight.w700),
            ),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }

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
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.all(12.0),
                            child: SvgPicture.asset("assets/icons/icon.svg")),
                        onTap: () {
                          showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            transitionDuration: Duration(milliseconds: 500),
                            barrierLabel:
                                MaterialLocalizations.of(context).dialogLabel,
                            barrierColor: Colors.black.withOpacity(0.5),
                            pageBuilder: (context, _, __) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      color: Colors.white,
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, bottom: 12),
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Card(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(height: 80),
                                              Text(
                                                "Currency Unit",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                alignment: Alignment.topRight,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    isCurrencyUSD
                                                        ? unselectedCurr("IDR")
                                                        : selectedCurrency(
                                                            "IDR"),
                                                    isCurrencyUSD
                                                        ? selectedCurrency(
                                                            "USD")
                                                        : unselectedCurr("USD"),
                                                  ],
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: _goto.length,
                                                itemBuilder: (_, int index) {
                                                  return paymentBox(
                                                      _goto[index]);
                                                },
                                              ),
                                            ],
                                          ),
                                          // SizedBox(height: 40),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SignOutButton(widget._ctx)
                                            ],
                                          )
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              );
                            },
                            transitionBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ).drive(Tween<Offset>(
                                  begin: Offset(1, -1),
                                  end: Offset.zero,
                                )),
                                child: child,
                              );
                            },
                          );
                        },
                      )
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
                    InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppPalette.instance.grey05,
                              borderRadius: BorderRadius.circular(6)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          child: SvgPicture.asset("assets/icons/sort.svg")),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Sort",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 10),
                                  LabeledRadio(
                                    label: 'Recomended',
                                    value: true,
                                    groupValue: _isRadioSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _isRadioSelected = newValue;
                                      });
                                    },
                                  ),
                                  LabeledRadio(
                                    label: 'Newest First',
                                    value: true,
                                    groupValue: _isRadioSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _isRadioSelected = newValue;
                                      });
                                    },
                                  ),
                                  LabeledRadio(
                                    label: 'Lowest Price',
                                    value: true,
                                    groupValue: _isRadioSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _isRadioSelected = newValue;
                                      });
                                    },
                                  ),
                                  LabeledRadio(
                                    label: 'Highest Price',
                                    value: true,
                                    groupValue: _isRadioSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _isRadioSelected = newValue;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text("Show",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 10),
                                  LabeledCheck(
                                    label: 'Losers',
                                    value: _loser,
                                    groupValue: _loser,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _loser = newValue;
                                      });
                                    },
                                  ),
                                  LabeledCheck(
                                    label: 'Gainers',
                                    value: _loser,
                                    groupValue: _loser,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _loser = newValue;
                                      });
                                    },
                                  ),
                                  LabeledCheck(
                                    label: 'Watchlist',
                                    value: _loser,
                                    groupValue: _loser,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _loser = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
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

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: <Widget>[
          Radio<bool>(
            groupValue: groupValue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
          SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}

class LabeledCheck extends StatelessWidget {
  const LabeledCheck({
    Key? key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
          SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
