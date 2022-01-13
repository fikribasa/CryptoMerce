import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wartec_app/style.dart';

class BasicLoading extends StatelessWidget {
  const BasicLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(12),
      width: 60,
      height: 60,
      child: CircularProgressIndicator(color: AppPalette.instance.accent2),
    ));
  }
}
