import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wartec_app/style.dart';

class PrimaryButton extends StatelessWidget {
  Function()? onPressed;
  String label;

  PrimaryButton({this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: AppPalette.instance.accent1, // background
          onPrimary: Colors.white, // foreground
        ),
        child: Text(
          label,
          style: AppPalette.instance.textStyleBold,
        ));
  }
}
