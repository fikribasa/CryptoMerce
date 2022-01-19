import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/account.dart';
import 'package:wartec_app/pages/login.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final userID = Auth().userLoggedIn();
      print("userID: $userID");
      Future.delayed(Duration(seconds: 2), () {
        if (userID != null && userID.length > 0) {
          Get.offAll(() => BasicBottomNavBar(widget._ctx!));
        } else {
          Get.offAll(() => LoginScreen(widget._ctx));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              child: Image.asset(
                "assets/icons/logomark-wartec.jpg",
                width: 240,
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
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "PT. Teknologi Sosial Nusantara",
                    style: TextStyle(
                        color: AppPalette.instance.accent5,
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
