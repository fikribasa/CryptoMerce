import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class AddNewBankScreen extends StatefulWidget {
  final AppContext? _ctx;
  final String? bankName;
  final String? image;

  AddNewBankScreen(this._ctx, this.bankName, this.image, {Key? key})
      : super(key: key);

  @override
  _AddNewBankScreenState createState() => _AddNewBankScreenState();
}

class _AddNewBankScreenState extends State<AddNewBankScreen> {
  final _controller = TextEditingController();

  get _getAppbar {
    return new AppBar(
        title: Text("Add a New Bank Account",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
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
        centerTitle: true);
  }

  Widget paymentBox(String title, String image) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  child: SvgPicture.asset(
                    image,
                    width: 30,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                      color: AppPalette.instance.grey10,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: _screenWidth,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        child: SvgPicture.asset(
                          widget.image!,
                          width: 50,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        widget.bankName ?? "",
                        style: TextStyle(
                            color: AppPalette.instance.grey10,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: _screenWidth,
                  child: Text("Account Number",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                Container(
                  width: _screenWidth,
                  decoration: BoxDecoration(
                    color: AppPalette.instance.grey05,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 12),
                  child: TextField(
                    controller: _controller,
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Label",
                        hintStyle: new TextStyle(color: Colors.black38)),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _screenWidth / 3,
                  child: PrimaryOutline(
                    label: "Check",
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          color: Colors.white,
          width: _screenWidth,
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: SizedBox(
            width: _screenWidth,
            child: PrimaryButton(
                label: "Continue",
                onPressed: _controller != null &&
                        _controller.text != null &&
                        _controller.text.length > 0
                    ? () {}
                    : null),
          )),
    );
  }
}
