import 'package:flutter/material.dart';

final _fontFamily = 'Inter';
final _fontSizeSmall = 14.0;
final _fontSizeNormal = 16.0;
final _fontSizeAppBar = 18.0;
final _fontSizeSection = 20.0;
final _primary = Color(0xffF7247A);
// final _gold = Color(0xffF5C259);
final _grey = Color(0x99000000);

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class AppPalette {
  static final AppPalette _singleton = AppPalette._internal();

  static AppPalette get instance => _singleton;

  AppPalette._internal();

  init() async {
    try {
      logo = "assets/icons/Icon-96.png";
      highlight = hexToColor("#3DCDC3");
      accent1 = hexToColor("#D27F19");
      accent2 = hexToColor("#F5C259");
      accent5 = hexToColor("#1FB393");

      primary = hexToColor("#ECFFFB");
      primary200 = hexToColor("#15377A");
      primary09 = hexToColor("#086F59");

      secondary = hexToColor("#FFF6EB");

      white = hexToColor("#ffffff");
      grey05 = hexToColor("#F2F2F2");
      grey10 = hexToColor("#3E4745");
      grey50 = hexToColor("#7F7F7F");

      brown = hexToColor("#715304");
      neutral05 = hexToColor("#8890A0");

      natural04 = hexToColor("#A4AAB6");
      natural07 = hexToColor("#555D6B");
      natural10 = hexToColor("#F9FAFA");
      neutral80 = hexToColor("#40454F");
      success400 = hexToColor("#27AE60");
      downtrend = hexToColor("#D90429");
    } catch (e) {
      print("Error init $e");
    }
  }

  final fontFamilyNormal = _fontFamily;
  final fontFamilyBold = _fontFamily;

  late final logo;
  late final Color white;
  late final Color accent1;
  late final Color accent2;
  late final Color accent5;
  late final Color grey05;
  late final Color grey10;
  late final Color grey50;
  late final Color neutral80;
  late final Color brown;
  late final Color natural04;
  late final Color natural07;
  late final Color natural10;
  late final Color neutral05;

  late final Color primary;
  late final Color primary200;
  late final Color primary09;
  late final Color highlight;
  late final Color success400;
  late final Color downtrend;

  late final Color secondary;
  final Color alert40 = hexToColor("#EB5757");

  final grey = _grey;
  final fontSizeNormal = _fontSizeNormal;
  final fontSizeAppBar = _fontSizeAppBar;
  final fontSizeSection = _fontSizeSection;

  final textStyleBold =
      TextStyle(fontSize: _fontSizeNormal, fontFamily: _fontFamily);
  final textStyleBoldPrimary = TextStyle(
      fontSize: _fontSizeNormal, fontFamily: _fontFamily, color: _primary);
  final textStyleBoldWhite = TextStyle(
      fontSize: _fontSizeNormal,
      fontFamily: _fontFamily,
      color: Color(0xffFFFFFF));

  final textStyleNormal =
      TextStyle(fontSize: _fontSizeNormal, fontFamily: _fontFamily);
  final textStyleNormalWhite = TextStyle(
      fontSize: _fontSizeNormal, fontFamily: _fontFamily, color: Colors.white);
  final outlineTextInput = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: hexToColor("#1FB393")));

  final textStyleAppBar =
      TextStyle(fontSize: _fontSizeAppBar, fontWeight: FontWeight.bold);
  final textStyleTheme = TextStyle(
      fontSize: 40.0, color: Colors.white, fontWeight: FontWeight.bold);
  final textStyleHeadline =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 28);
  final textStyleThemePrimary = TextStyle(
      fontSize: 40.0,
      color: hexToColor("#D27F19"),
      fontWeight: FontWeight.bold);

  final textStyleSmall =
      TextStyle(fontSize: _fontSizeSmall, fontFamily: _fontFamily);
  final textStylePrimary = TextStyle(
      fontSize: 16.0, fontFamily: _fontFamily, color: hexToColor("#1FB393"));
  final textStyleSmallPrimary = TextStyle(
      fontSize: _fontSizeSmall,
      fontFamily: _fontFamily,
      color: hexToColor("#1FB393"));

  final themeExpansionTile =
      ThemeData(accentColor: Colors.black, dividerColor: Colors.white);
}

class StyleSelectedBox {
  final Color backgroundColor = AppPalette.instance.highlight;
}
