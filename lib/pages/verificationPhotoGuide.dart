import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/verificationCamera.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class VerificationPhotoGuideScreen extends StatefulWidget {
  final AppContext? _ctx;
  final String? photoType;
  final String? documentType;

  VerificationPhotoGuideScreen(this._ctx, this.photoType, this.documentType,
      {Key? key})
      : super(key: key);

  @override
  _VerificationPhotoGuideScreenState createState() =>
      _VerificationPhotoGuideScreenState();
}

class _VerificationPhotoGuideScreenState
    extends State<VerificationPhotoGuideScreen> {
  get _getAppbar {
    return new AppBar(
      title: Text("${widget.documentType} Photo Guide",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _imageHeight = _screenWidth * 0.5 * 3 / 4;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Container(
                  width: _screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: _screenWidth * 0.45,
                        height: _imageHeight,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  child: Image.asset(
                                      "assets/icons/upload-grey.png",
                                      width: _screenWidth * 0.45)),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SvgPicture.asset('assets/icons/true.svg'),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: _screenWidth * 0.45,
                        height: _imageHeight,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  child: Image.asset(
                                      "assets/icons/upload-grey-cropped.png",
                                      width: _screenWidth * 0.45)),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SvgPicture.asset('assets/icons/false.svg'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BulletText(
                            "${widget.documentType} must fit in the frame."),
                        BulletText(
                            "Personal information on your ${widget.documentType} must be clearly visible (not blurry, cropped, or reflecting light)."),
                        BulletText("${widget.documentType} must be valid."),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 60),
        width: _screenWidth,
        child: PrimaryButton(
          label: "Take a Photo",
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  late String txt;
  BulletText(String t) {
    txt = t;
  }

  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('\u2022'),
        SizedBox(width: 5),
        Expanded(child: Text(txt))
      ],
    );
  }
}
