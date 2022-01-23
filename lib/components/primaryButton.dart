import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wartec_app/style.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;

  PrimaryButton({this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: AppPalette.instance.accent5, // background
            onPrimary: Colors.white, // foreground
            shape: StadiumBorder()),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ));
  }
}

class PrimaryButtonSmall extends StatelessWidget {
  final Function()? onPressed;
  final String label;

  PrimaryButtonSmall({this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: AppPalette.instance.accent5, // background
            onPrimary: Colors.white, // foreground
            shape: StadiumBorder()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(label,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Icon(Icons.navigate_next)
          ],
        ));
  }
}

class PrimaryOutline extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final TextStyle? textStyle;

  PrimaryOutline({required this.label, this.onPressed, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(width: 0.5, color: AppPalette.instance.accent5),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Text(
            label,
            style: textStyle ??
                TextStyle(
                    color: AppPalette.instance.accent5,
                    fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
    );
  }
}
