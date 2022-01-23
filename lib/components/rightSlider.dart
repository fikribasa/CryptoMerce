import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
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
import 'package:wartec_app/utils/storage.dart';

class RightSliderWidget extends StatefulWidget {
  final AppContext _ctx;
  final Widget? icon;

  RightSliderWidget(this._ctx, {Key? key, this.icon}) : super(key: key);

  @override
  _RightSliderWidgetState createState() => _RightSliderWidgetState();
}

class _RightSliderWidgetState extends State<RightSliderWidget> {
  bool isCurrencyUSD = false;

  final _goto = [
    "My Wallet",
    "My Bank Accounts",
    "Watchlist",
    "Hide Coin",
    "",
    "About"
  ];

  final Map<String, String> _options = {
    "My Wallet": 'assets/icons/wallet.svg',
    "My Bank Accounts": 'assets/icons/university.svg',
    "Watchlist": 'assets/icons/star-brown.svg',
    "Hide Coin": 'assets/icons/bitcoin-circle.svg',
    "Settings": 'assets/icons/setting.svg',
    "About": 'assets/icons/info.svg',
  };

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
            border: Border.all(
              color: AppPalette.instance.accent5,
            ),
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
            border: Border.all(
              color: AppPalette.instance.accent5,
            ),
            borderRadius: BorderRadius.circular(
              4.0,
            )),
      ),
    );
  }

  Widget itemBox(BuildContext _buildContext, String title, String image) {
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
        // decoration: BoxDecoration(
        //     border: Border.all(width: 1.0, color: Colors.black12),
        //     borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              child: SvgPicture.asset(
                image,
                width: 30,
              ),
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  color: AppPalette.instance.grey10,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderProfileImage() {
    return Container(
      width: 30.0,
      height: 30.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: widget._ctx.user != null && widget._ctx.user!.imageUrl != null
            ? FancyShimmerImage(
                imageUrl: "",
                shimmerBaseColor: AppPalette.instance.accent5,
              )
            : Image.asset("assets/images/profile.jpg"),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        left: 12, right: 12, bottom: 12, top: 20),
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => AccountScreen(widget._ctx));
                                  },
                                  child: Row(children: [
                                    _renderProfileImage(),
                                    SizedBox(width: 6),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(this.widget._ctx.user?.fullName ??
                                            "-"),
                                        Text(
                                          this.widget._ctx.user?.email ??
                                              storage.read("userEmail") ??
                                              "-",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppPalette
                                                  .instance.neutral05),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Icon(Icons.chevron_right))
                                  ]),
                                ),
                                SizedBox(height: 10),
                                Divider(color: Colors.black12, thickness: 1.0),
                                SizedBox(height: 10),
                                Text(
                                  "Currency Unit",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
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
                                    String key = _options.keys.elementAt(index);
                                    return itemBox(
                                        dialogContext, key, _options[key]!);
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
                begin: Offset(-1, 0),
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
