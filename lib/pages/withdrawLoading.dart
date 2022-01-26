import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/virtualAccount.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class WithdrawLoadingScreen extends StatefulWidget {
  final AppContext? _ctx;

  const WithdrawLoadingScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _WithdrawLoadingScreenState createState() => _WithdrawLoadingScreenState();
}

class _WithdrawLoadingScreenState extends State<WithdrawLoadingScreen>
    with TickerProviderStateMixin {
  bool _isWaiting = true;
  late double _screenWidth;

  AnimationController? animation;
  Animation<double>? _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    checkConfirmation();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.25).animate(animation!);

    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation!.forward();
      }
    });
    animation!.forward();
  }

  @override
  void dispose() {
    animation?.dispose();
    super.dispose();
  }

  checkConfirmation() {
    Future.delayed(Duration(seconds: 4), () {
      this.setState(() {
        _isWaiting = false;
      });
    });
  }

  Widget confirmed() {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/loan.png"),
            Text(
              "Withdraw In Process",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.instance.neutral80),
            ),
            Text(
              "We will process your withdraw within 24 hours. You will receive a notification when it’s done.",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppPalette.instance.neutral80),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: _screenWidth * 0.5,
        color: Colors.white,
        child: PrimaryButton(
            label: "Go to Home",
            onPressed: () {
              Get.offAll(() => BasicBottomNavBar(widget._ctx!, index: 0));
            }),
      ),
    );
  }

  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return _isWaiting
        ? Scaffold(
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _fadeInFadeOut!,
                    child: Image.asset("assets/images/loan.png"),
                  ),
                ],
              ),
            )),
          )
        : confirmed();
  }
}
