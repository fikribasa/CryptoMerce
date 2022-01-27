import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/transaction.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/firestoreDB.dart';
import 'package:wartec_app/style.dart';
import 'package:wartec_app/utils/storage.dart';

class PinInputCheckerScreen extends StatefulWidget {
  final AppContext? _ctx;
  final String? type;
  final Widget? afterSuccess;

  PinInputCheckerScreen(AppContext? ctx, this.type, this.afterSuccess,
      {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _PinInputCheckerScreenState createState() => _PinInputCheckerScreenState();
}

class _PinInputCheckerScreenState extends State<PinInputCheckerScreen> {
  Size? _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;
  int? _fifthDigit;
  int? _sixthDigit;

  String pin = "";

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   userPin = storage.read("userPin");
    // });
  }

  Future checkPinToFirebase() async {
    try {
      final userid = storage.read("userID");
      final user = await DBFuture().getUser(userid);
      if (user?.pin != null) {
        if (user?.pin == pin) {
          Get.snackbar("Sukses", "PIN telah sesuai, terima kasih");
          return Get.to(() => widget.afterSuccess!);
        } else {
          return Get.snackbar(
              "Terjadi Kesalahan", "PIN tidak sesuai, mohon periksa lagi");
        }
      }
      return Get.snackbar(
          "Terjadi Kesalahan", "PIN tidak ditemukan, mohon periksa lagi");
    } catch (e) {
      print("checkPinToFirebase: $e");
      // Get.snackbar("Terjadi Kesalahan", "$e");
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
    setState(() {
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

        pin = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString() +
            _fifthDigit.toString() +
            _sixthDigit.toString();

        // Verify your pin by here. API call
      }
    });
    print(pin.length);
    if (pin.length == 6) {
      checkPinToFirebase();
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
      title: Text(
          widget.type == "new"
              ? "Confirm Your PIN"
              : widget.type == "change"
                  ? "Change PIN"
                  : "Enter Wartec PIN to Continue",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
      backgroundColor: Colors.white,
      elevation: 1.0,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
              widget.type == "new"
                  ? "Enter your PIN one more time to confirm"
                  : widget.type == "change"
                      ? "Enter your current 6-digit PIN to change your PIN"
                      : "Please enter your 6 digit PIN.",
              style: TextStyle(fontSize: 14.0)),
        ),
        widget.type != "new"
            ? Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text("Forgot your PIN?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0, color: AppPalette.instance.neutral05)),
              )
            : SizedBox(height: 1),
      ],
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
                        // next page
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
