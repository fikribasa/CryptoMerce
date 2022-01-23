import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/virtualAccount.dart';
import 'package:wartec_app/services/appContext.dart';

class LoadingVerificationScreen extends StatefulWidget {
  final AppContext? _ctx;

  const LoadingVerificationScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _LoadingVerificationScreenState createState() =>
      _LoadingVerificationScreenState();
}

class _LoadingVerificationScreenState extends State<LoadingVerificationScreen>
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
            Image.asset("assets/images/document.png"),
            SizedBox(height: 20),
            Text("Transaction Confirmed"),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: _screenWidth * 0.5,
        color: Colors.white,
        child: PrimaryButton(
            label: "Go to Ledger",
            onPressed: () {
              Get.offAll(() => BasicBottomNavBar(widget._ctx!, index: 3));
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
                    child: Image.asset("assets/images/Illustration.png"),
                  ),
                  SizedBox(height: 20),
                  Text("Verifying Your Transaction....."),
                ],
              ),
            )),
          )
        : confirmed();
  }
}
