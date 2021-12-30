import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/login.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class SplashScreen extends StatefulWidget {
  final AppContext? _ctx;

  SplashScreen(AppContext? ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  void checkLoginState() {
    Future.delayed(Duration(seconds: 1), () {
      Get.to(() => LoginScreen(widget._ctx));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.instance.accent1,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              child: Text(
                "WARTEC",
                style: AppPalette.instance.textStyleTheme,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Powered By",
                    style: TextStyle(color: AppPalette.instance.white),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "PT. Teknologi Sosial Nusantara",
                    style: TextStyle(
                        color: AppPalette.instance.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
