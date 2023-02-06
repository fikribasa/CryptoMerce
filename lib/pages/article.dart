import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wartec_app/models/headlines.dart';
import 'package:wartec_app/style.dart';

class ArticleScreen extends StatelessWidget {
  final HeadlineItem? article;
  const ArticleScreen(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _imageWidth = _screenWidth * 0.7;

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
                          text: this.article!.sourceName ?? "",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: this.article!.date ?? "",
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
              Text(this.article!.title ?? "",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: _imageWidth,
                  height: _imageWidth,
                  child: FancyShimmerImage(
                    imageUrl: this.article!.imageUrl!,
                    shimmerBaseColor: AppPalette.instance.accent5,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(this.article!.text ?? "",
                  style: TextStyle(color: AppPalette.instance.neutral80)),
            ],
          ),
        ),
      ),
    );
  }
}
