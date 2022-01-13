import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/components/signout.dart';
import 'package:wartec_app/pages/account.dart';
import 'package:wartec_app/pages/ledger.dart';
import 'package:wartec_app/pages/watchlist.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class RightSliderWidget extends StatefulWidget {
  final AppContext _ctx;
  final Widget? icon;

  RightSliderWidget(this._ctx, {Key? key, this.icon}) : super(key: key);

  @override
  _RightSliderWidgetState createState() => _RightSliderWidgetState();
}

class _RightSliderWidgetState extends State<RightSliderWidget> {
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

  Widget paymentBox(BuildContext _buildContext, String title) {
    return InkWell(
      onTap: () {
        Navigator.pop(_buildContext);

        if (title == "Watchlist") {
          Get.to(() => WatchlistScreen(widget._ctx));
        } else if (title == "Account") {
          Get.to(() => AccountScreen(widget._ctx));
        } else if (title == "My Wallet") {
          Get.offAll(() => BasicBottomNavBar(widget._ctx, index: 3));
        }
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.icon != null
          ? widget.icon
          : Container(
              padding: EdgeInsets.all(12.0),
              child: SvgPicture.asset("assets/icons/icon.svg")),
      onTap: () {
        BuildContext dialogContext;

        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 500),
          barrierLabel: MaterialLocalizations.of(context).dialogLabel,
          barrierColor: Colors.black.withOpacity(0.5),
          pageBuilder: (context, _, __) {
            dialogContext = context;

            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              "Currency Unit",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
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
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _goto.length,
                              itemBuilder: (_, int index) {
                                return paymentBox(dialogContext, _goto[index]);
                              },
                            ),
                          ],
                        ),
                        // SizedBox(height: 40),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [SignOutButton(widget._ctx)],
                        )
                      ],
                    )),
                  ),
                ],
              ),
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
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
    );
  }
}
