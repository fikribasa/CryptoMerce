import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/signup.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/style.dart';

class LoginScreen extends StatefulWidget {
  final AppContext? _ctx;
  LoginScreen(AppContext? ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _isObscure = true;

  loginHandler() async {
    String? _returnString;
    try {
      _returnString = await Auth().loginUserWithEmail(_email!, _password!);
      print("_returnString: $_returnString");
      if (_returnString == "success") {
        Get.to(() => BasicBottomNavBar(widget._ctx!));
      } else
        throw Exception(_returnString);
    } catch (e) {
      // handle error
      Get.snackbar("Mohon maaf", "Email / password tidak sesuai",
          duration: Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.0),
                Text("Wartec",
                    style: AppPalette.instance.textStyleThemePrimary),
                Text(
                  "Warung Technology Ecosystem & Cryptocurrency",
                  style: TextStyle(
                      color: AppPalette.instance.grey10, fontSize: 12.0),
                ),
                SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 8.0),
                            hintStyle: AppPalette.instance.textStyleSmall,
                            enabledBorder: AppPalette.instance.outlineTextInput,
                            focusedBorder: AppPalette.instance.outlineTextInput,
                            border: AppPalette.instance.outlineTextInput,
                            hintText: 'Email Address'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: _isObscure,
                        autocorrect: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 8.0),
                            hintStyle: AppPalette.instance.textStyleSmall,
                            enabledBorder: AppPalette.instance.outlineTextInput,
                            focusedBorder: AppPalette.instance.outlineTextInput,
                            border: AppPalette.instance.outlineTextInput,
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                })),
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                      SizedBox(height: 12.0),
                      SizedBox(
                        width: _screenWidth,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Forgot Password?",
                              style: AppPalette.instance.textStyleSmallPrimary),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      SizedBox(
                          width: _screenWidth,
                          child: PrimaryButton(
                              onPressed: _email != null && _password != null
                                  ? () {
                                      loginHandler();
                                    }
                                  : null,
                              label: 'Log in')),
                      SizedBox(height: 12.0),
                      SizedBox(
                          width: _screenWidth,
                          child: TextButton(
                              onPressed: () {
                                Get.to(() => SignUpScreen(widget._ctx));
                              },
                              child: Text("Sign Up",
                                  style:
                                      AppPalette.instance.textStylePrimary))),
                      SizedBox(height: 12.0),
                      Container(
                        width: _screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Divider(
                                    color: Colors.black26, thickness: 1.0)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "OR",
                                style: TextStyle(color: Colors.black26),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                                    color: Colors.black26, thickness: 1.0))
                          ],
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/fn.svg"),
                                SizedBox(width: 4),
                                Text("Log In with FansNya",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: hexToColor("#F74545")))
                              ],
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
