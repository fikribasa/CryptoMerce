import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/CoinCard.dart';
import 'package:wartec_app/components/assetWidget.dart';
import 'package:wartec_app/components/basicLoading.dart';
import 'package:wartec_app/components/profileWidget.dart';
import 'package:wartec_app/components/rightSlider.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/assetIDR.dart';
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
  bool _isLoading = true;

  TokenList? _tokenList;
  @override
  void initState() {
    super.initState();
    getTokenList();
  }

  getTokenList() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _tl = await widget._ctx.api.getTokenList();
      this.setState(() {
        _isLoading = false;
        _tokenList = _tl;
      });
    });
  }

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
            color: AppPalette.instance.accent5,
            border: Border.all(color: AppPalette.instance.accent5),
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
          style: TextStyle(color: AppPalette.instance.accent5, fontSize: 11.0),
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

  Widget _renderHeader(double _screenWidth) {
    return Container(
      width: _screenWidth - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            RightSliderWidget(widget._ctx, icon: ProfileWidget(widget._ctx)),
            SizedBox(width: 12),
            Text("Ledger", style: AppPalette.instance.textStyleAppBar),
          ]),
          SvgPicture.asset("assets/icons/icon.svg"),
        ],
      ),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          16.0,
          16.0,
          16.0,
          0,
        ),
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
                      _renderHeader(_screenWidth),
                    ],
                  )),
              SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AssetDropDownWidget(),
                      TimeFrameDropDownWidget()
                    ]),
              ),
              SizedBox(height: 40.0),
              Container(
                  child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/ledger.png",
                          width: _screenWidth,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
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
                      ),
                    ],
                  ),
                  SizedBox(
                    width: _screenWidth,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Assets",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppPalette.instance.neutral05),
                            ),
                            Text("IDR 59,291,100",
                                style: TextStyle(fontWeight: FontWeight.w400)),
                            SizedBox(height: 10),
                            Text(
                              "Today’s profit & loss",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppPalette.instance.neutral05),
                            ),
                            Text(
                              "IDR 59,291,100",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
              SizedBox(height: 20.0),
              _isLoading
                  ? Container()
                  : Container(
                      width: _screenWidth,
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          AssetCoin(widget._ctx, _tokenList!.item![0],
                              index: 0),
                          AssetCoin(widget._ctx, _tokenList!.item![1],
                              index: 1),
                          InkWell(
                              onTap: () {
                                Get.to(() => AssetIDRScreen(widget._ctx));
                              },
                              child: AssetFiat(widget._ctx, index: 0)),
                          AssetFiat(widget._ctx, index: 1),
                        ],
                      ),
                    ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/icons/donut.png",
                      width: 250,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text("Rp 59,291,100",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(
                          "Total Investment",
                          style: TextStyle(
                              color: AppPalette.instance.neutral05,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              _isLoading
                  ? Container()
                  : Container(
                      // width: _screenWidth,
                      height: 24,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          AssetShort(
                            color: hexToColor("#05F300"),
                            title: "Rupiah",
                            change: "13.49%",
                          ),
                          AssetShort(
                            color: hexToColor("#F3E300"),
                            title: "ZACoin",
                            change: "62.60%",
                          ),
                          AssetShort(
                            color: hexToColor("#0033AD"),
                            title: "US Dollar",
                            change: "7.05%",
                          ),
                          AssetShort(
                            color: hexToColor("#FFB965"),
                            title: "Bitcoin",
                            change: "16.86%",
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 20.0),
              Text("Assets",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              _isLoading
                  ? BasicLoading()
                  : _tokenList != null && _tokenList!.item != null
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (_, int index) {
                            return CoinCard(
                                widget._ctx, _tokenList!.item![index],
                                showChart: false);
                          },
                        )
                      : Center(child: Text("Loading"))
            ],
          ),
        )),
      ),
    );
  }
}

class AssetDropDownWidget extends StatefulWidget {
  const AssetDropDownWidget({Key? key}) : super(key: key);

  @override
  State<AssetDropDownWidget> createState() => _AssetDropDownWidgetState();
}

class _AssetDropDownWidgetState extends State<AssetDropDownWidget> {
  String dropdownValue = 'Total Asset';

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
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
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
          items: <String>['Total Asset', 'Asset 1', 'Asset 2']
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

class TimeFrameDropDownWidget extends StatefulWidget {
  const TimeFrameDropDownWidget({Key? key}) : super(key: key);

  @override
  State<TimeFrameDropDownWidget> createState() =>
      _TimeFrameDropDownWidgetState();
}

class _TimeFrameDropDownWidgetState extends State<TimeFrameDropDownWidget> {
  String dropdownValue = 'Weekly';

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
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
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
          items: <String>['Daily', 'Weekly', 'Monthly']
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
