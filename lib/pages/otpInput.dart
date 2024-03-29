import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class OTPInputScreen extends StatefulWidget {
  final String? email;
  final AppContext? _ctx;
  final EmailAuth? emailAuth;
  final Widget? afterSuccess;

  OTPInputScreen(this._ctx, this.email, this.emailAuth, this.afterSuccess,
      {Key? key})
      : super(key: key);

  @override
  _OTPInputScreenState createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  Size? _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;
  int? _fifthDigit;
  int? _sixthDigit;

  String pin = "";

  verifyOTP() {
    var res = widget.emailAuth!
        .validateOtp(recipientMail: widget.email!, userOtp: pin);
    if (res) {
      Get.snackbar("Verification Success", "Thank you");
      Get.off(() => widget.afterSuccess!);
    } else {
      print("at verifyOTP > $res");
      Get.snackbar("Verification Failed", "Please check your input");
    }
  }

  // Returns "Pin custom text field"
  Widget _pinTextField(int? digit) {
    return new Container(
        width: 30.0,
        height: 40.0,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: AppPalette.instance.neutral05,
          width: 2.0,
        ))),
        alignment: Alignment.center,
        child: digit != null
            ? Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppPalette.instance.accent5, // border color
                  shape: BoxShape.circle,
                )
                // Text(
                //   "${digit ?? ""}",
                //   style: TextStyle(
                //       fontSize: 28,
                //       fontWeight: FontWeight.bold,
                //       color: AppPalette.instance.accent5),
                )
            : Container());
  }

  // Returns "Pin keyboard input Button"
  Widget _pinKeyboardInputButton({String? label, VoidCallback? onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(30.0),
        child: new Container(
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label!,
              style: new TextStyle(
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Pin keyboard action Button"
  _pinKeyboardActionButton({Widget? label, VoidCallback? onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    _currentDigit = i;
    if (_firstDigit == null) {
      _firstDigit = _currentDigit;
    } else if (_secondDigit == null) {
      _secondDigit = _currentDigit;
    } else if (_thirdDigit == null) {
      _thirdDigit = _currentDigit;
    } else if (_fourthDigit == null) {
      _fourthDigit = _currentDigit;
    } else if (_fifthDigit == null) {
      _fifthDigit = _currentDigit;
    } else if (_sixthDigit == null) {
      _sixthDigit = _currentDigit;
    }
    setState(() {
      pin = _firstDigit.toString() +
          _secondDigit.toString() +
          _thirdDigit.toString() +
          _fourthDigit.toString() +
          _fifthDigit.toString() +
          _sixthDigit.toString();

      // Verify your pin by here. API call
    });
    print(pin.length);
    if (pin.length == 6) {
      verifyOTP();
      print("terpanggil");
    }
  }

  void clearPin() {
    _sixthDigit = null;
    _fifthDigit = null;
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }

  // Returns "Appbar"
  get _getAppbar {
    return new AppBar(
      elevation: 1.0,
      title: Text("OTP Verification",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
      backgroundColor: Colors.white,
      leading: new InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: new Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
    );
  }

  get _title {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Please input the one-time password (OTP) that we’ve sent to",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0)),
          SizedBox(height: 10),
          Text(widget.email ?? " ", style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }

  // Return "PIN" input field
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _pinTextField(_firstDigit),
        _pinTextField(_secondDigit),
        _pinTextField(_thirdDigit),
        _pinTextField(_fourthDigit),
        _pinTextField(_fifthDigit),
        _pinTextField(_sixthDigit),
      ],
    );
  }

  // Returns "Pin" keyboard
  get _getPinKeyboard {
    return new Container(
        height: _screenSize!.width - 80,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _pinKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _pinKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _pinKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _pinKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _pinKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _pinKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _pinKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _pinKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _pinKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _pinKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _pinKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_sixthDigit != null) {
                            _sixthDigit = null;
                          } else if (_fifthDigit != null) {
                            _fifthDigit = null;
                          } else if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Returns "OTP" input part
  get _getInputPart {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[_title, _getInputField, _getPinKeyboard],
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: new Container(
        width: _screenSize!.width,
        child: _getInputPart,
      ),
    );
  }
}
