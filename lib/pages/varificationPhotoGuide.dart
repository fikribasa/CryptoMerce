import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/components/signout.dart';
import 'package:wartec_app/pages/personalInfoInput.dart';
import 'package:wartec_app/pages/varificationCamera.dart';
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
      backgroundColor: Colors.white,
      elevation: 0.0,
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.documentType} Photo Guide",
                    style: AppPalette.instance.textStyleHeadline),
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
                BulletText("${widget.documentType} must fit in the frame."),
                BulletText(
                    "Personal information on your ${widget.documentType} must be clearly visible (not blurry, cropped, or reflecting light)."),
                BulletText("${widget.documentType} must be valid."),
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
          label: "Next",
          onPressed: () {
            Get.off(() => VerificationCameraScreen());
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
