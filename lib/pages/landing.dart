import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/account.dart';
import 'package:wartec_app/pages/tokenDetail.dart';
import 'package:wartec_app/pages/watchlist.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/services/firestoreDB.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/storage.dart';

class LandingPage extends StatefulWidget {
  final AppContext? _ctx;
  LandingPage(AppContext? ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isLoading = true;
  TokenList? _tokenList;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // get userInfo
      if (widget._ctx!.user == null) {
        // final user = await widget._ctx!.api.getUserInfo();
        final user = await DBFuture().getUser(storage.read("userID"));
        widget._ctx!.user = user;
      }
      final _tl = await widget._ctx!.api.getTokenList();
      this.setState(() {
        _isLoading = false;
        _tokenList = _tl;
      });
    });
  }

  Widget _renderProfileImage() {
    return InkWell(
      onTap: () {
        Get.to(() => AccountScreen(widget._ctx));
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child:
              widget._ctx!.user != null && widget._ctx!.user!.imageUrl != null
                  ? FancyShimmerImage(
                      imageUrl: "",
                      shimmerBaseColor: AppPalette.instance.accent5,
                    )
                  : Image.asset("assets/images/profile.png"),
        ),
      ),
    );
  }

  Widget coinCard(TokenItem? item) {
    return InkWell(
      onTap: () {
        Get.to(() => TokenDetailScreen(widget._ctx, item));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        margin: const EdgeInsets.only(bottom: 6.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  item!.image!,
                  width: 32,
                  height: 32,
                )),
            SizedBox(width: 6.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.code!, style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 6.0),
                  Text(
                    item.name ?? "",
                    style: TextStyle(
                        color: AppPalette.instance.grey10, fontSize: 12),
                    maxLines: 1,
                  )
                ],
              ),
            ),
            Expanded(flex: 2, child: Image.asset("assets/images/chart.png")),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Rp " + item.tokenPriceIDR,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                      item.change! >= 0
                          ? "+${item.change}\%"
                          : "${item.change}\%",
                      style: TextStyle(
                          fontSize: 10.0,
                          color: item.change! >= 0
                              ? Colors.green
                              : hexToColor("#BF2121")))
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
          _tokenList != null && _tokenList!.item != null
              ? ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: _tokenList!.item!.length,
                  itemBuilder: (_, int index) {
                    return coinCard(_tokenList!.item![index]);
                  },
                )
              : Center(
                  child: Text("Loading"),
                ),
        ],
      ),
    );
  }

  get getUserName {
    var _str = "";
    if (widget._ctx!.user != null && widget._ctx!.user!.fullName != null) {
      _str = widget._ctx!.user!.fullName!;
    } else if (storage.read("userEmail") != null) {
      _str = storage.read("userEmail");
    }
    return _str;
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
          _tokenList != null && _tokenList!.item != null
              ? ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: _tokenList!.item!.length,
                  itemBuilder: (_, int index) {
                    return coinCard(_tokenList!.item![index]);
                  },
                )
              : Center(
                  child: Text("Loading"),
                ),
        ],
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Text("Loading"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? _loadingWidget()
            : SafeArea(
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
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
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
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold))
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
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: SvgPicture.asset(
                                          'assets/icons/bell.svg')),
                                ),
                                SizedBox(width: 10.0),
                                _renderProfileImage()
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
                          text: " " + getUserName,
                          style: TextStyle(
                            color: AppPalette.instance.accent5,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          )),
                    ])),
                    SizedBox(height: 20.0),
                    Text("Assets",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    Container(
                      width: _screenWidth,
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Container(
                              child: Image.asset("assets/images/wc2.png")),
                          Container(
                              child: Image.asset("assets/images/wc11.png")),
                          Container(
                              child: Image.asset("assets/images/wc21.png")),
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
