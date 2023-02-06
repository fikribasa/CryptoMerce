import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/changePassword.dart';
import 'package:wartec_app/pages/pinInput.dart';
import 'package:wartec_app/pages/pinInputChecker.dart';
import 'package:wartec_app/pages/verifyIdetity.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/storage.dart';

class AccountScreen extends StatefulWidget {
  final AppContext? _ctx;

  AccountScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late double _screenWidth;

  get _getAppbar {
    return new AppBar(
      title: Text("My Account",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
      backgroundColor: Colors.white,
      elevation: 1.0,
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

  Widget _getForm(String? title, String? text, [bool showDivider = true]) {
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
          showDivider
              ? Divider(color: Colors.black12, thickness: 1.0)
              : SizedBox(width: _screenWidth)
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

  Widget _verifyButton(double _screenWidth) {
    // if (_ctx!.user != null) {
    //   return SizedBox(height: 1, width: 1);
    // }
    return InkWell(
      onTap: () {
        Get.to(() => VerifyIdentityScreen(this.widget._ctx!));
      },
      child: Container(
        width: _screenWidth,
        // alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 4.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("Verify your identity to unlock all features"),
          SizedBox(height: 10.0),
          Text(
            "Verify Now",
            style: TextStyle(
                color: AppPalette.instance.accent5,
                fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }

  Widget ActionBox(String title) {
    return InkWell(
      onTap: () {
        if (title.contains("Password")) {
          Get.to(() => ChangePasswordScreen(this.widget._ctx));
        } else {
          Get.to(() => PinInputCheckerScreen(
              this.widget._ctx,
              "change",
              PinInputScreen(this.widget._ctx, "change",
                  BasicBottomNavBar(widget._ctx!))));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(width: 1.0, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppPalette.instance.grey10,
                  fontWeight: FontWeight.w700),
            ),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: widget._ctx!.user != null &&
                              widget._ctx!.user!.imageUrl != null
                          ? FancyShimmerImage(
                              imageUrl: "",
                              shimmerBaseColor: AppPalette.instance.accent5,
                            )
                          : Image.asset("assets/images/profile.jpg"),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _verifyButton(_screenWidth),
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Column(
                    children: [
                      _getForm(
                          "Full Name", this.widget._ctx!.user?.fullName ?? "-"),
                      _getForm("KTP Number",
                          this.widget._ctx!.user?.ktpNumber ?? "-"),
                      _getForm("Phone Number",
                          this.widget._ctx!.user?.phoneNumber ?? "-"),
                      _getForm(
                          "Email",
                          this.widget._ctx!.user?.email ??
                              storage.read("userEmail") ??
                              "-",
                          false),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text("Security", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                ActionBox("Change Password"),
                ActionBox("Change PIN"),
                // SignOutButton(this.widget._ctx!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
