import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/article.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class ChannelScreen extends StatefulWidget {
  final AppContext _ctx;
  ChannelScreen(AppContext ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final TextEditingController _controller = new TextEditingController();
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
              SizedBox(height: 8),
              Text("Channel", style: AppPalette.instance.textStyleAppBar),
              Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: AppPalette.instance.accent5,
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 4.0),
                  child: Text("News",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
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
              Text(
                "Top News",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              Text("Recent News",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              InkWell(
                onTap: () {
                  Get.to(() => ArticleScreen());
                },
                child: Container(
                  height: 100.0,
                  width: _screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("CRYPTO NEWS",
                                style: TextStyle(
                                  color: AppPalette.instance.grey10,
                                  fontSize: 10.0,
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Cryptocurrencies To Watch This New Year: HUH Token and Safem...",
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("11 hr ago · 2 min read",
                                style: TextStyle(
                                    color: AppPalette.instance.grey10,
                                    fontSize: 10.0)),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Image.asset("assets/images/news.png")),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black12, thickness: 1.0)
            ],
          ),
        )),
      ),
    );
  }
}
