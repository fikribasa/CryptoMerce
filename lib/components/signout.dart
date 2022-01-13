import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/splash.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class SignOutButton extends StatelessWidget {
  final AppContext? _ctx;
  const SignOutButton(this._ctx, {Key? key}) : super(key: key);
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: TextStyle(color: AppPalette.instance.primary200)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget signOutButton = TextButton(
      child: Text("Sign Out",
          style: TextStyle(color: AppPalette.instance.primary200)),
      onPressed: () async {
        await this._ctx!.logout();
        Get.offAll(() => SplashScreen(this._ctx!));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("AlertDialog"),
      content: Text("Are you sure you want to sign out?"),
      actions: [
        cancelButton,
        signOutButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: _screenWidth,
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        label: SvgPicture.asset('assets/icons/out.svg'),
        icon: Text("Sign Out",
            style: TextStyle(color: AppPalette.instance.primary200)),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}
