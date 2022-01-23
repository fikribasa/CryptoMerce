import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/account.dart';
import 'package:wartec_app/pages/landing.dart';
import 'package:wartec_app/services/appContext.dart';

class PinInputScreen extends StatefulWidget {
  final AppContext? _ctx;
  PinInputScreen(AppContext? ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _PinInputScreenState createState() => _PinInputScreenState();
}

class _PinInputScreenState extends State<PinInputScreen> {
  Size? _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;
  int? _fifthDigit;
  int? _sixthDigit;

  String pin = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  // Returns "Pin custom text field"
  Widget _pinTextField(int? digit) {
    return new Container(
        width: 30.0,
        height: 40.0,
        alignment: Alignment.center,
        child: digit != null
            ? SvgPicture.asset("assets/icons/elipse-bl.svg")
            : SvgPicture.asset("assets/icons/elipse.svg"));
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
      Get.offAll(() => BasicBottomNavBar(widget._ctx!, index: 0));
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
      backgroundColor: Colors.transparent,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Create Your PIN",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 20.0),
        Text("Input a 6-digit PIN to enhance your security",
            style: TextStyle(fontSize: 14.0)),
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
