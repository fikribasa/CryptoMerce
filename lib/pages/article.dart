import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/style.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _screenWidth,
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "CRYPTO NEWS",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: "· 9 hr ago · 2 min read",
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38)),
                    ])),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.black38,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                  "Cryptocurrencies To Watch This News Year: HUH Token and Safemoon",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              SizedBox(height: 20.0),
              Text(
                  "With the New Year moments away, it’s no wonder that the resolutions are being written, the eldest sibling is preparing to run out and in of the house to signify taking out the old and bringing in the new… and we’re all dolled up to the eyeballs with some kind of paper hat on our heads…",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
              Text(
                  "But what does this mean for cryptocurrencies this coming year, 2022, and why HUH Token and Safemoon could be the ones to watch after the countdown to midnight of course!",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
              Container(
                  width: _screenWidth,
                  child: Image.asset(
                    "assets/images/article.png",
                    fit: BoxFit.contain,
                  )),
              SizedBox(height: 20.0),
              Text("A New Year, HUH?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Text(
                  "Over the past couple of years, it could have felt like dolling in the new year was somewhat pointless… another day the same reheated soup kind of deal, however, as things begin to look brighter it’s not just a new feeling of life, we could look forward too but the promising future of this young thing – HUH Token",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
              Text(
                  "HUH Token in its first month put on a dazzling show for its holders and crypto lovers alike… from burning USD 1million worth of HUH Token to amassing over 172million in market cap… demonstrating that HUH Token might just be one of the longest running shows on the cryptocurrency stage.  ",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
              Text(
                  "Though, if you managed to excuse my poor West End analogy, then you could be delighted to know that HUH Token have now aim of slowing down, in fact, they’re rather vigorous about moving forward and upwards.",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
              Text(
                  "This might be achievable, amongst many things, with their smart referral contract: the holder receives a unique code, that when used, gives the holder a 10%BNB bonus for the referred’s first deposit. The referred party also receives a 10% sales fee reduction. The code can be used for as many people as you like.",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
              Text(
                  "If you’d like to do some further research into HUH Token, you can do so by clicking the links attached to the bottom of this article. ",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
              Text("A Safemoon Filled Sky This Year",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Text(
                  "Safemoon released its V2 transition stage, and it appears, through internet rumours, that Safemoon could be one of the coins to keep any eye on as it continues to amass popularity.",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
