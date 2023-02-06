import 'dart:io';

import 'package:camera/camera.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/accountVerification.dart';
import 'package:wartec_app/pages/otpInput.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/services/firestoreDB.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/storage.dart';

class PersonalInfoInputScreen extends StatefulWidget {
  final XFile? photoID;
  final XFile? photoSelfie;
  final AppContext? _ctx;

  PersonalInfoInputScreen(this._ctx, this.photoID, this.photoSelfie, {Key? key})
      : super(key: key);

  @override
  _PersonalInfoInputScreenState createState() =>
      _PersonalInfoInputScreenState();
}

class _PersonalInfoInputScreenState extends State<PersonalInfoInputScreen> {
  String _email = storage.read("userEmail");
  String? idNumber;
  String? fullName;
  String? phoneNumber;
  bool _isLoading = false;
  String suffix = "+62";
  TextEditingController dateCtl = TextEditingController();
  final dateFormatter = DateFormat('DD-MM-yyyy');
  EmailAuth? emailAuth;

  get _getAppbar {
    return new AppBar(
      title: Text("Personal Info",
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

  formDecoration(String? hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      hintStyle: AppPalette.instance.textStyleSmall,
      enabledBorder: AppPalette.instance.outlineTextInput,
      focusedBorder: AppPalette.instance.outlineTextInput,
      border: AppPalette.instance.outlineTextInput,
      hintText: hint,
    );
  }

  onRegister() async {
    if (_email.length == 0 ||
        idNumber == null ||
        fullName == null ||
        dateCtl.text.length == 0 ||
        phoneNumber == null) {
      Get.snackbar("Terjadi Kesalahan", "Mohon lengkapi isian anda");
      return null;
    } else if (widget.photoID == null || widget.photoSelfie == null) {
      Get.snackbar("Mohon maaf", "Mohon lengkapi photo anda");
    } else {
      try {
        this.setState(() {
          _isLoading = true;
        });
        Get.snackbar("Sedang Dalam Proses", "Mohon ditunggu");
        final reg = await Auth().signUpUser(
            _email, fullName!, idNumber!, suffix + phoneNumber!, dateCtl.text);
        await uploadImageToFirebase(widget.photoID!.path, "photoID");
        await uploadImageToFirebase(widget.photoSelfie!.path, "photoSelfie");
        if (reg == "success") {
          // Get.to(() => AccountVerification(widget._ctx, _email));
          await sendEmail();
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Silakan coba lagi.\n$e");
        this.setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future sendEmail() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      emailAuth = new EmailAuth(sessionName: "Wartec");
      var res = await emailAuth!.sendOtp(recipientMail: _email, otpLength: 4);
      if (res) {
        this.setState(() {
          _isLoading = false;
        });
        Get.to(() => OTPInputScreen(widget._ctx, _email, emailAuth!,
            AccountVerification(widget._ctx, _email)));
      }
    });
  }

  Future uploadImageToFirebase(String? filePath, String? type) async {
    try {
      final userid = storage.read("userID");
      String fileName = "$type-$userid"; //  basename(filePath);
      print(fileName);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(File(filePath!));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      taskSnapshot.ref.getDownloadURL().then(
            (value) => print("Done: $value"),
          );
      final link = await taskSnapshot.ref.getDownloadURL();
      await DBFuture().updateUser(userid, type!, link);
    } catch (e) {
      print("uploadImageToFirebase: $e");
      Get.snackbar("Terjadi Kesalahan", "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 40.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TextFormField(
                  autocorrect: false,
                  initialValue: _email,
                  decoration: formDecoration("Email"),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  autocorrect: false,
                  decoration: formDecoration("KTP Number"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      idNumber = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  autocorrect: false,
                  decoration: formDecoration("Full Name"),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: dateCtl,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                      hintStyle: AppPalette.instance.textStyleSmall,
                      enabledBorder: AppPalette.instance.outlineTextInput,
                      focusedBorder: AppPalette.instance.outlineTextInput,
                      border: AppPalette.instance.outlineTextInput,
                      hintText: "DOB",
                      suffixIcon: Icon(Icons.date_range_outlined, size: 22)),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    dateCtl.text = dateFormatter.format(date!);
                  },
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color: AppPalette.instance.natural04)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 8.0),
                          child: Text(
                            "+62",
                            style: TextStyle(fontSize: 18),
                          )),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          autocorrect: false,
                          decoration: formDecoration("Ex: 812345678"),
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Country / Area cannot be changed later",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _isLoading
          ? Container(
              padding: const EdgeInsets.all(12),
              width: 60,
              height: 60,
              child:
                  CircularProgressIndicator(color: AppPalette.instance.accent2),
            )
          : Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              width: _screenWidth,
              child: PrimaryButton(label: "Next", onPressed: onRegister),
            ),
    );
  }
}
