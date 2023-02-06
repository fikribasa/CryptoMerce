import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/login.dart';
import 'package:wartec_app/pages/pinInputChecker.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/services/firestoreDB.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/storage.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userID = Auth().userLoggedIn();
      print("userID: $userID");
      if (userID != null && userID.length > 0) {
        final user = await DBFuture().getUser(userID);
        if (user != null && user.pin != null && user.pin!.length > 0) {
          storage.write("pin", user.pin);
          return Get.offAll(() => PinInputCheckerScreen(
              widget._ctx!, "login", BasicBottomNavBar(widget._ctx!)));
        }
      }
      return Get.offAll(() => LoginScreen(widget._ctx));
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
