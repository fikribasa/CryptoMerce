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
        ),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ));
  }
}
