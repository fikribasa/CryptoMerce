import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/components/signout.dart';
import 'package:wartec_app/pages/verificationUpload.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class VerificationDocTypeScreen extends StatefulWidget {
  final AppContext? _ctx;

  VerificationDocTypeScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _VerificationDocTypeScreenState createState() =>
      _VerificationDocTypeScreenState();
}

class _VerificationDocTypeScreenState extends State<VerificationDocTypeScreen> {
  int documentType = 1;
  final List<String> documentTexts = [
    'KTP',
    'SIM',
    'Passport / KITAS / KITAP',
  ];

  get _getAppbar {
    return new AppBar(
      title: Text("Choose an ID type",
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

  handlePayMethodChange(dynamic value) {
    return setState(() {
      this.documentType = value;
    });
  }

  String getDocType() {
    if (documentType == 3) {
      return "Document";
    }
    return documentTexts[documentType - 1];
  }

  Widget radioBuilder(String _title, int _value) {
    return InkWell(
      onTap: () {
        this.handlePayMethodChange(_value);
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                color: _value == documentType
                    ? AppPalette.instance.primary
                    : Colors.white,
                border:
                    Border.all(width: 0, color: AppPalette.instance.accent5),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _title,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Radio(
                    activeColor: AppPalette.instance.accent5,
                    value: _value,
                    groupValue: this.documentType,
                    onChanged: this.handlePayMethodChange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16, 16.0, 16.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select one of the these documents to verify your identity.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    radioBuilder(documentTexts[0], 1),
                    radioBuilder(documentTexts[1], 2),
                    radioBuilder(documentTexts[2], 3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 60),
        width: _screenWidth,
        child: PrimaryButton(
          label: "Next",
          onPressed: () {
            Get.to(() => VerificationUploadScreen(widget._ctx!, getDocType()));
          },
        ),
      ),
    );
  }
}
