import 'package:flutter/material.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/landing.dart';
import 'package:wartec_app/pages/login.dart';
import 'package:wartec_app/pages/splash.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPalette.instance.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WartecApp(AppContext.instance);
  }
}

class WartecApp extends StatefulWidget {
  final AppContext _ctx;

  WartecApp(AppContext ctx) : _ctx = ctx;
  @override
  State<StatefulWidget> createState() => _WartecApp();
}

class _WartecApp extends State<WartecApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    widget._ctx.navigatorKey = navigatorKey;
    return GetMaterialApp(
        title: 'Wartec',
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            // start
            return MaterialPageRoute(
                builder: (context) => LandingPage(
                      widget._ctx,
                    ));
          }
        },
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        // home: BasicBottomNavBar(widget._ctx));
        home: LoginScreen(widget._ctx));
  }
}
