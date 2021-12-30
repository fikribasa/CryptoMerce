import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/style.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  get _getAppbar {
    return new AppBar(
      title: Text("My Account",
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

  Widget _getForm(String? title, String? text) {
    return Container(
      padding: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: TextStyle(color: AppPalette.instance.grey50),
          ),
          SizedBox(height: 4.0),
          Text(text ?? ""),
          SizedBox(height: 4.0),
          Divider(color: Colors.black12, thickness: 1.0)
        ],
      ),
    );
  }

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
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("AlertDialog"),
      content: Text("Are you sure you want to sign out?"),
      actions: [
        signOutButton,
        cancelButton,
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
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: _screenWidth,
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/profile.png")),
                SizedBox(height: 20.0),
                Container(
                  width: _screenWidth,
                  // alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8.0, left: 8.0, right: 4.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Verify your identity to unlock all features"),
                        SizedBox(height: 10.0),
                        Text(
                          "Verify Now",
                          style: TextStyle(
                              color: AppPalette.instance.accent1,
                              fontWeight: FontWeight.w600),
                        )
                      ]),
                ),
                SizedBox(height: 20.0),
                _getForm("Full Name", "-"),
                _getForm("KTP Number", "-"),
                _getForm("Phone Number", "-"),
                _getForm("Email", "rommyp@gmail.com"),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  width: _screenWidth,
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    label: SvgPicture.asset('assets/icons/out.svg'),
                    icon: Text("Sign Out",
                        style:
                            TextStyle(color: AppPalette.instance.primary200)),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
