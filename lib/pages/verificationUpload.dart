import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/personalInfoInput.dart';
import 'package:wartec_app/pages/verificationCamera.dart';
import 'package:wartec_app/pages/verificationPhotoGuide.dart';
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
  XFile? photoID;
  XFile? photoSelfie;

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

  Widget imagePreview(double _screenWidth, XFile? _file) {
    return Container(
        width: _screenWidth,
        padding: EdgeInsets.only(top: 40, bottom: 40),
        color: AppPalette.instance.secondary,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(_file!.path),
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Container(
              color: Colors.white60,
              child: OutlinedButton(
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Reupload",
                      style: TextStyle(
                          color: AppPalette.instance.accent1,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        ));
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
                  child: photoID != null
                      ? imagePreview(_screenWidth, photoID)
                      : InkWell(
                          onTap: () async {
                            final _proceed = await Get.to(() =>
                                VerificationPhotoGuideScreen(widget._ctx!,
                                    "document", "${widget.documentType}"));
                            if (_proceed) {
                              final _respondPhoto = await Get.to(
                                  () => VerificationCameraScreen("document"));
                              if (_respondPhoto != null) {
                                this.setState(() {
                                  photoID = _respondPhoto;
                                });
                              }
                            }
                          },
                          child: Container(
                            width: _screenWidth,
                            padding: EdgeInsets.only(top: 40, bottom: 40),
                            color: AppPalette.instance.secondary,
                            child: Column(
                              children: [
                                Container(
                                    child: Image.asset(
                                        "assets/icons/upload.png",
                                        width: 70,
                                        height: 70)),
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
                  child: photoSelfie != null
                      ? imagePreview(_screenWidth, photoSelfie)
                      : InkWell(
                          onTap: () async {
                            final _proceed = await Get.to(() =>
                                VerificationPhotoGuideScreen(widget._ctx!,
                                    "selfie", "${widget.documentType}"));
                            if (_proceed) {
                              final _respondPhoto = await Get.to(
                                  () => VerificationCameraScreen("selfie"));
                              if (_respondPhoto != null) {
                                this.setState(() {
                                  photoSelfie = _respondPhoto;
                                });
                              }
                            }
                          },
                          child: Container(
                            width: _screenWidth,
                            padding: EdgeInsets.only(top: 30, bottom: 30),
                            color: AppPalette.instance.secondary,
                            child: Column(
                              children: [
                                photoSelfie != null
                                    ? Image.file(
                                        File(photoSelfie!.path),
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.contain,
                                      )
                                    : Container(
                                        child: Image.asset(
                                            "assets/icons/upload.png",
                                            width: 70,
                                            height: 70)),
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
          onPressed: photoID != null && photoSelfie != null
              ? () {
                  Get.off(() => PersonalInfoInputScreen(
                      widget._ctx!, photoID, photoSelfie));
                }
              : null,
        ),
      ),
    );
  }
}
