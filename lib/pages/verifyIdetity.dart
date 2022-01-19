import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/verifcationDocType.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class VerifyIdentityScreen extends StatelessWidget {
  final AppContext? _ctx;

  VerifyIdentityScreen(this._ctx, {Key? key}) : super(key: key);
  get _getAppbar {
    return new AppBar(
      title: Text("Identity Verification Needed",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16, 16.0, 16.0),
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
                      Text(
                        "Verification required for your transactions and asset security.",
                        textAlign: TextAlign.center,
                      ),
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
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
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
