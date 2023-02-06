import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class ProfileWidget extends StatelessWidget {
  AppContext? _ctx;
  ProfileWidget(this._ctx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: _ctx!.user != null && _ctx!.user!.imageUrl != null
            ? FancyShimmerImage(
                imageUrl: "",
                shimmerBaseColor: AppPalette.instance.accent5,
              )
            : Image.asset("assets/images/profile.jpg"),
      ),
    );
  }
}
