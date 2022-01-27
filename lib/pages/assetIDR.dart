import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/idrWithdraw.dart';
import 'package:wartec_app/pages/virtualAccount.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class AssetIDRScreen extends StatefulWidget {
  final AppContext? _ctx;

  AssetIDRScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _AssetIDRScreenState createState() => _AssetIDRScreenState();
}

class _AssetIDRScreenState extends State<AssetIDRScreen> {
  bool _isHistoryEmpty = false;
  get _getAppbar {
    return new AppBar(
      title: Text("Rupiah",
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
        body: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            child: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/idr.png",
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: 6),
                            Text("Indonesian Rupiah"),
                          ],
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            "Rp 7,890,138",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: double.infinity,
                                  child: PrimaryButton(
                                      label: "Deposit",
                                      onPressed: () {
                                        Get.to(() =>
                                            VirtualAccountScreen(widget._ctx));
                                      })),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                child: PrimaryOutline(
                                    label: "Withdraw",
                                    onPressed: () {
                                      Get.to(
                                          () => IDRWithdrawScreen(widget._ctx));
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _isHistoryEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/crypto-transaction.png",
                                width: 300,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "You have no transaction",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text("Add funds here to get started")
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("28 December 2021",
                                style: TextStyle(fontSize: 12)),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0)),
                              width: _screenWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/arrow-down.svg'),
                                      SizedBox(width: 6),
                                      Text("Buy"),
                                      SizedBox(width: 6),
                                      Image.asset("assets/icons/zaq.png",
                                          width: 16.0),
                                      SizedBox(width: 6),
                                      Text("ZACoin"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "-Rp 2,000,000",
                                        style: TextStyle(
                                            color: AppPalette.instance.alert40),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "18:00",
                                        style: TextStyle(
                                            color:
                                                AppPalette.instance.neutral80,
                                            fontSize: 10),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0)),
                              width: _screenWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    SvgPicture.asset(
                                        'assets/icons/deposit.svg'),
                                    SizedBox(width: 6),
                                    Text("Deposit"),
                                  ]),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("+Rp 1,000,000",
                                          style: TextStyle(
                                              color: AppPalette
                                                  .instance.success400)),
                                      SizedBox(height: 4),
                                      Text("09:40",
                                          style: TextStyle(
                                              color:
                                                  AppPalette.instance.neutral80,
                                              fontSize: 10))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                ])))));
  }
}
