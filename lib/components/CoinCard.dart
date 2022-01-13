import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/pages/tokenDetail.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class CoinCard extends StatelessWidget {
  final AppContext? _ctx;
  final TokenItem? item;
  bool showChart = true;
  CoinCard(this._ctx, this.item, {Key? key, this.showChart = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => TokenDetailScreen(_ctx, item));
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
                  Text(item!.code ?? "", style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 6.0),
                  Text(
                    item!.name ?? "",
                    style: TextStyle(
                        color: AppPalette.instance.grey10, fontSize: 12),
                    maxLines: 1,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: showChart
                    ? item!.change! >= 0
                        ? Image.asset("assets/images/chart.png")
                        : Image.asset("assets/images/chart-down.png")
                    : SizedBox(width: 10)),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Rp " + item!.tokenPriceIDR,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                      item!.change! >= 0
                          ? "+${item!.change}\%"
                          : "${item!.change}\%",
                      style: TextStyle(
                          fontSize: 10.0,
                          color: item!.change! >= 0
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
}
