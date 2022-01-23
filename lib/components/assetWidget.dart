import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/tokenDetail.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class AssetCoin extends StatelessWidget {
  AppContext? ctx;
  TokenItem? item;
  int index;
  AssetCoin(this.ctx, this.item, {Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => TokenDetailScreen(ctx, item));
      },
      child: Container(
        height: 180,
        width: 150,
        color: Colors.white,
        margin: const EdgeInsets.only(right: 4),
        child: Stack(children: [
          Align(
            child: Image.asset(
              index == 0
                  ? "assets/images/bg-yellow.png"
                  : "assets/images/bg-orange.png",
              width: 160,
            ),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        item!.image!,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        item!.name ?? "",
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("407.98 ${item!.code}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      SizedBox(height: 4),
                      Text("idrxxx",
                          style: TextStyle(
                              color: AppPalette.instance.natural07,
                              fontSize: 12)),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset('assets/icons/deposit-simple.svg'),
                          Text("|",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10)),
                          SvgPicture.asset('assets/icons/withdraw-simple.svg'),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AssetFiat extends StatelessWidget {
  AppContext? ctx;
  int index;
  AssetFiat(this.ctx, {Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 160,
      color: Colors.white,
      margin: const EdgeInsets.only(right: 4),
      child: Stack(children: [
        Align(
          child: Image.asset(
            index == 0
                ? "assets/images/bg-green.png"
                : "assets/images/bg-blue.png",
            width: 170,
          ),
          alignment: Alignment.bottomCenter,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      index == 0
                          ? "assets/images/idr.png"
                          : "assets/images/usd.png",
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      index == 0 ? "Rupiah" : "US Dollar",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(index == 0 ? "Rp 8,000,000" : "\$298.15",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    SizedBox(height: 4),
                    Text(index == 0 ? "" : "IDR 4,174,100",
                        style: TextStyle(
                            color: AppPalette.instance.natural07,
                            fontSize: 12)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset('assets/icons/deposit-simple.svg'),
                        Text("|",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 10)),
                        SvgPicture.asset('assets/icons/withdraw-simple.svg'),
                        Text("|",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 10)),
                        SvgPicture.asset('assets/icons/withdraw-fiat.svg'),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class AssetShort extends StatelessWidget {
  Color? color;
  String? title;
  String? change;
  AssetShort({Key? key, this.color, this.title, this.change}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color ?? AppPalette.instance.accent5)),
          SizedBox(width: 6),
          Text(
            title ?? "",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 6),
          Text(change ?? "",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppPalette.instance.neutral05)),
        ],
      ),
    );
  }
}
