import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget listBuilder(String number, String text) {
  return Flex(
    crossAxisAlignment: CrossAxisAlignment.start,
    direction: Axis.horizontal,
    children: [
      Expanded(
        flex: 1,
        child: Text(number + '.', style: TextStyle(color: Colors.black38)),
      ),
      Expanded(
        flex: 16,
        child: Text(text, style: TextStyle(color: Colors.black38)),
      )
    ],
  );
}
