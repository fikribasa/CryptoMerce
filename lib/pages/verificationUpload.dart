import 'package:dotted_border/dotted_border.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/components/signout.dart';
import 'package:wartec_app/pages/personalInfoInput.dart';
import 'package:wartec_app/pages/varificationPhotoGuide.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class VerificationUploadScreen extends StatefulWidget {
  final AppContext? _ctx;
  final String? documentType;

  VerificationUploadScreen(this._ctx, this.documentType, {Key? key})
      : super(key: key);

  @override
  _VerificationUploadScreenState createState() =>
      _VerificationUploadScreenState();
}

class _VerificationUploadScreenState extends State<VerificationUploadScreen> {
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
                Text("Upload ${widget.documentType}",
                    style: AppPalette.instance.textStyleHeadline),
                SizedBox(height: 40),
                DottedBorder(
                  color: AppPalette.instance.accent2,
                  strokeWidth: 2,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => VerificationPhotoGuideScreen(
                          widget._ctx!, "document", "${widget.documentType}"));
                    },
                    child: Container(
                      width: _screenWidth,
                      padding: EdgeInsets.only(top: 40, bottom: 40),
                      color: AppPalette.instance.secondary,
                      child: Column(
                        children: [
                          Container(
                              child: Image.asset("assets/icons/upload.png",
                                  width: 70, height: 70)),
                          Text(
                              "Tap to take a photo of your ${widget.documentType}")
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DottedBorder(
                  color: AppPalette.instance.accent2,
                  strokeWidth: 2,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => VerificationPhotoGuideScreen(
                          widget._ctx!, "selfie", "${widget.documentType}"));
                    },
                    child: Container(
                      width: _screenWidth,
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      color: AppPalette.instance.secondary,
                      child: Column(
                        children: [
                          Container(
                              child: Image.asset("assets/icons/upload.png",
                                  width: 70, height: 70)),
                          Text(
                              "Tap to take a selfie with your ${widget.documentType}")
                        ],
                      ),
                    ),
                  ),
                )
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
            Get.off(() => PersonalInfoInputScreen(widget._ctx!));
          },
        ),
      ),
    );
  }
}
