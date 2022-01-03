import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:wartec_app/style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextAlign textAlign;
  final Function(String)? onChange;
  CustomTextField(
      {this.controller, this.onChange, this.textAlign = TextAlign.start});

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        textAlign: widget.textAlign,
        autocorrect: false,
        maxLines: 1,
        enableSuggestions: false,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        controller: widget.controller,
        onChanged: widget.onChange,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[\\.|\\,|0-9]')),
        ],
        style: TextStyle(
            color: AppPalette.instance.primary09,
            fontSize: 20,
            fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "0",
            contentPadding:
                EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0)));
  }
}
