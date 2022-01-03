import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/pages/pinInput.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/storage.dart';

class PersonalInfoInputScreen extends StatefulWidget {
  final AppContext? _ctx;

  PersonalInfoInputScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _PersonalInfoInputScreenState createState() =>
      _PersonalInfoInputScreenState();
}

class _PersonalInfoInputScreenState extends State<PersonalInfoInputScreen> {
  String _email = storage.read("userEmail");
  String? idNumber;
  String? fullName;
  String? phoneNumber;
  String suffix = "+62";
  TextEditingController dateCtl = TextEditingController();
  final dateFormatter = DateFormat('DD-MM-yyyy');

  get _getAppbar {
    return new AppBar(
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
    } else {
      try {
        final reg = await Auth().signUpUser(
            _email, fullName!, idNumber!, suffix + phoneNumber!, dateCtl.text);
        if (reg == "success") {
          Get.offAll(() => BasicBottomNavBar(widget._ctx!));
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Silakan coba lagi.\n$e");
      }
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
                Text("Personal Info",
                    style: AppPalette.instance.textStyleHeadline),
                SizedBox(height: 40),
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
                    suffixIcon: Icon(Icons.date_range_outlined, size: 22),
                    // suffixIconConstraints: BoxConstraints(
                    //   minWidth: 2,
                    //   minHeight: 2,
                    // ),
                  ),
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
                              border: Border.all(color: hexToColor("#A4AAB6"))),
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
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 60),
        width: _screenWidth,
        child: PrimaryButton(label: "Next", onPressed: onRegister),
      ),
    );
  }
}
