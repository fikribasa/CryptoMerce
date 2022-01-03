import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/components/signout.dart';
import 'package:wartec_app/pages/verifcationDocType.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class VerifyIdentityScreen extends StatelessWidget {
  final AppContext? _ctx;

  VerifyIdentityScreen(this._ctx, {Key? key}) : super(key: key);
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
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: _screenHeight * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Identity Verification Needed",
                          style: AppPalette.instance.textStyleHeadline),
                      SizedBox(height: 6),
                      Text(
                          "Verification required for your transactions and asset security."),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/encrypted.png",
                          width: _screenWidth * 0.8,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppPalette.instance.grey05,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Text(
                            "Please prepare your KTP / SIM / Passport and good lighting condition "),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: _screenWidth,
                        child: PrimaryButton(
                          label: "Verify Now",
                          onPressed: () {
                            Get.to(() => VerificationDocTypeScreen(this._ctx!));
                          },
                        ),
                      ),
                      Container(
                        width: _screenWidth,
                        child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Later",
                                style: AppPalette.instance.textStylePrimary)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
