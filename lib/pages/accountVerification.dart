import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/pages/pinInput.dart';

class AccountVerification extends StatelessWidget {
  final AppContext? _ctx;
  AccountVerification(AppContext? ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);
  get _getAppbar {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new InkWell(
        child: new Icon(
          Icons.close,
          color: Colors.black,
          size: 30,
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
      backgroundColor: Colors.white,
      appBar: _getAppbar,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Verification",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                      "We have sent an email with a link to verify your account. Please check your email inbox.",
                      style: TextStyle(fontSize: 14.0)),
                  SizedBox(height: 40.0),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: _screenWidth,
                height: _screenWidth,
                child: FittedBox(
                  child: Image.asset("assets/images/securedData.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Get.to(() => PinInputScreen(_ctx));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    "Resend Email",
                    style: AppPalette.instance.textStyleSmallPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
