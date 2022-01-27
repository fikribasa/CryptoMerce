import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/CoinCard.dart';
import 'package:wartec_app/components/assetWidget.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/components/rightSlider.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/account.dart';
import 'package:wartec_app/pages/assetIDR.dart';
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

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  Widget _renderProfileImage() {
    return Container(
      width: 30.0,
      height: 30.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: widget._ctx!.user != null && widget._ctx!.user!.imageUrl != null
            ? FancyShimmerImage(
                imageUrl: "",
                shimmerBaseColor: AppPalette.instance.accent5,
              )
            : Image.asset("assets/images/profile.jpg"),
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
                    return CoinCard(widget._ctx, _tokenList!.item![index]);
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
                  itemCount: _tokenList!.item!.length - 2,
                  itemBuilder: (_, int index) {
                    return CoinCard(widget._ctx, _tokenList!.item![index]);
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

  Widget _renderHeader(double _screenWidth) {
    return Container(
      width: _screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RightSliderWidget(widget._ctx!, icon: _renderProfileImage()),
          Container(
              child:
                  Image.asset("assets/icons/logomark-wartec.png", width: 40.0)),
          Container(
            width: 40.0,
            height: 40,
            child: TextButton(
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/bell.svg')),
          ),
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
        child: _isLoading
            ? _loadingWidget()
            : SafeArea(
                child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderHeader(_screenWidth),
                    SizedBox(height: 10.0),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Good ${greeting()},",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      TextSpan(
                          text: " " + getUserName,
                          style: TextStyle(
                            color: AppPalette.instance.accent5,
                            fontWeight: FontWeight.w400,
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
                    SizedBox(height: 20.0),
                    Container(
                      width: _screenWidth,
                      height: 800,
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
