import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/style.dart';

class ChangePasswordScreen extends StatefulWidget {
  final AppContext? ctx;
  ChangePasswordScreen(this.ctx, {Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? _password;
  String? _confirmationNewPassword;
  String? _newPassword;

  bool _isObscure = true;
  bool _isObscureConfirmation = true;
  bool _isObscureNewPassword = true;

  get _getAppbar {
    return new AppBar(
      title: Text("Change Password",
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

   _changePassword() async {
    if (_password == null ||
        _newPassword == null ||
        _confirmationNewPassword == null ||
        _password!.isEmpty ||
        _newPassword!.isEmpty ||
        _confirmationNewPassword!.isEmpty) {
      return Get.snackbar(
          "Terjadi Kesalahan", "Mohon periksa kembali password anda",
          duration: Duration(seconds: 4));
    }
    try {
      if (_newPassword!.trim() != _confirmationNewPassword!.trim()) {
        return Get.snackbar("Terjadi Kesalahan",
            "Password baru tidak sesuai, mohon periksa kembali",
            duration: Duration(seconds: 4));
      }
      String _returnString =
          await Auth().changePassword(_password!, _newPassword!);
      print(_returnString);
      if (_returnString == "success") {
        Get.snackbar("Success", "Change password successful",
            duration: Duration(seconds: 4));
        Get.back();
      } else {
        if (_returnString.contains("wrong-password")) {
          Get.snackbar("Terjadi Kesalahan",
              "Password tidak sesuai, mohon periksa kembali",
              duration: Duration(seconds: 4));
        } else if (_returnString.contains("too-many-requests")) {
          Get.snackbar("Terjadi Kesalahan",
              "Terlalu banyak permintaan, silakan coba lagi dalam 3 jam ke depan",
              duration: Duration(seconds: 4));
        } else {
          Get.snackbar("Terjadi Kesalahan", "Silakan coba lagi",
              duration: Duration(seconds: 4));
        }
      }
    } catch (e) {
      print(e);
      Get.snackbar("Terjadi Kesalahan", "Silakan coba lagi \n$e",
          duration: Duration(seconds: 4));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                    "Your password must contain at least 8 characters, with capital letter(s), small letter(s), and number(s) in it."),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: _isObscure,
                  autocorrect: false,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                      hintStyle: AppPalette.instance.textStyleSmall,
                      enabledBorder: AppPalette.instance.outlineTextInput,
                      focusedBorder: AppPalette.instance.outlineTextInput,
                      border: AppPalette.instance.outlineTextInput,
                      hintText: 'Current Password',
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
                SizedBox(height: 20),
                TextFormField(
                  obscureText: _isObscureNewPassword,
                  autocorrect: false,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                      hintStyle: AppPalette.instance.textStyleSmall,
                      enabledBorder: AppPalette.instance.outlineTextInput,
                      focusedBorder: AppPalette.instance.outlineTextInput,
                      border: AppPalette.instance.outlineTextInput,
                      hintText: 'New Password',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscureNewPassword = !_isObscureNewPassword;
                            });
                          })),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _newPassword = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: _isObscureConfirmation,
                  autocorrect: false,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                      hintStyle: AppPalette.instance.textStyleSmall,
                      enabledBorder: AppPalette.instance.outlineTextInput,
                      focusedBorder: AppPalette.instance.outlineTextInput,
                      border: AppPalette.instance.outlineTextInput,
                      hintText: 'Confirm New Password',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscureConfirmation = !_isObscureConfirmation;
                            });
                          })),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _confirmationNewPassword = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: _screenWidth,
                  child: PrimaryButton(
                      onPressed: _changePassword, label: 'Change Password'),
                ),
              ],
            ),
          )),
    );
  }
}
