import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/loadingVerification.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class PinVerification extends StatefulWidget {
  final AppContext? _ctx;

  PinVerification(this._ctx, {Key? key}) : super(key: key);

  @override
  _PinVerificationState createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  get _getAppbar {
    return new AppBar(
      title: Text("Enter Wartec PIN to continue",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: new InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: new Icon(
          Icons.close,
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: _screenWidth,
              child: Text(
                "Please enter your 6 digit PIN.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppPalette.instance.grey10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => LoadingVerificationScreen(widget._ctx!));
                },
                child: Text("Next"))
          ],
        )),
      )),
    );
  }
}
