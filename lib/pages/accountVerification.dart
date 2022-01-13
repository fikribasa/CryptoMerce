import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/otpInput.dart';
import 'package:wartec_app/services/appContext.dart';

class AccountVerification extends StatefulWidget {
  final String? email;
  final AppContext? _ctx;
  AccountVerification(this._ctx, this.email, {Key? key}) : super(key: key);

  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  EmailAuth? emailAuth;
  bool isSend = false;
  @override
  void initState() {
    super.initState();
    sendEmail();
  }

  sendEmail() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      emailAuth = new EmailAuth(sessionName: "Wartec");
      var res =
          await emailAuth!.sendOtp(recipientMail: widget.email!, otpLength: 4);
      if (res) {
        this.setState(() {
          isSend = true;
        });
        Get.to(() => OTPInputScreen(widget._ctx, widget.email!, emailAuth!));
      }

      /// Configuring the remote server
      // emailAuth!.config(remoteServerConfiguration);
    });
  }

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
                  Text("We are trying to send OTP to your Email, please wait",
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
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     height: 100,
            //     child: Column(
            //       children: [
            //         PrimaryButton(
            //             label: "Go To Home",
            //             onPressed: () {
            //               Get.offAll(BasicBottomNavBar(widget._ctx!));
            //             }),
            //         SizedBox(height: 10),
            //         InkWell(
            //           onTap: () {
            //             Get.to(() => OTPInputScreen(
            //                 widget._ctx, widget.email!, emailAuth!));
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.only(bottom: 10.0),
            //             child: Text(
            //               "Resend Email",
            //               style: AppPalette.instance.textStyleSmallPrimary,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}
