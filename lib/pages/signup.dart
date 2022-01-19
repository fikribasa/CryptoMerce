import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/accountVerification.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/style.dart';

class SignUpScreen extends StatefulWidget {
  final AppContext? _ctx;
  SignUpScreen(AppContext? ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _confirmationPassword;
  bool _isObscure = true;
  bool _isObscureConfirmation = true;

  void _signUpEmail() async {
    try {
      print(_email);
      print(_password);
      if (_password!.trim() != _confirmationPassword!.trim()) {
        return Get.snackbar(
            "Terjadi Kesalahan", "Password tidak sesuai, mohon periksa kembali",
            duration: Duration(seconds: 4));
      }
      String _returnString = await Auth().signUpWithEmail(_email!, _password!);
      if (_returnString == "success") {
        Get.to(() => AccountVerification(widget._ctx, _email!));
      } else {
        Get.snackbar("Terjadi Kesalahan", "Silakan coba lagi",
            duration: Duration(seconds: 4));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(children: [
        Align(
          child: Image.asset(
            "assets/images/header.png",
            width: _screenWidth,
          ),
          alignment: Alignment.topCenter,
        ),
        Align(
          child: Image.asset(
            "assets/images/footer.png",
            width: _screenWidth,
          ),
          alignment: Alignment.bottomCenter,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/logotype-wartec.png",
                    width: 160,
                  ),
                  Text(
                    "Warung Technology Ecosystem & Cryptocurrency",
                    style: TextStyle(
                        color: AppPalette.instance.grey10, fontSize: 12.0),
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          autocorrect: false,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              hintStyle: AppPalette.instance.textStyleSmall,
                              enabledBorder:
                                  AppPalette.instance.outlineTextInput,
                              focusedBorder:
                                  AppPalette.instance.outlineTextInput,
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
                              enabledBorder:
                                  AppPalette.instance.outlineTextInput,
                              focusedBorder:
                                  AppPalette.instance.outlineTextInput,
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
                        SizedBox(height: 4.0),
                        Text(
                          "Must contain at least 8 characters, with capital letter(s), small letter(s), and number(s) in it.",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          obscureText: _isObscureConfirmation,
                          autocorrect: false,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              hintStyle: AppPalette.instance.textStyleSmall,
                              enabledBorder:
                                  AppPalette.instance.outlineTextInput,
                              focusedBorder:
                                  AppPalette.instance.outlineTextInput,
                              border: AppPalette.instance.outlineTextInput,
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscureConfirmation
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureConfirmation =
                                          !_isObscureConfirmation;
                                    });
                                  })),
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            setState(() {
                              _confirmationPassword = value;
                            });
                          },
                        ),
                        SizedBox(height: 12.0),
                        Text("By signing up, you agree to our",
                            style: TextStyle(fontSize: 12.0)),
                        SizedBox(height: 6.0),
                        Text("Terms & Conditions",
                            style: AppPalette.instance.textStyleSmallPrimary),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 140,
                          child: PrimaryButtonSmall(
                              onPressed: () {
                                _signUpEmail();
                              },
                              label: 'Sign Up      '),
                        ),
                        SizedBox(height: 12.0),
                        SizedBox(
                            width: _screenWidth,
                            child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Log In",
                                    style:
                                        AppPalette.instance.textStylePrimary))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
