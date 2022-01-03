import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wartec_app/components/bottomTab.dart';
import 'package:wartec_app/pages/landing.dart';
import 'package:wartec_app/pages/login.dart';
import 'package:wartec_app/pages/splash.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/prefs.dart';
import 'package:wartec_app/style.dart';

import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future setPref() async {
  await dotenv.load(fileName: ".env");
  await pref.init();
  if (pref.backendServer?.isEmpty ?? true) {
    pref.backendServer = dotenv.env['BACKEND_SERVER'];
  }
  pref.newsURL = dotenv.env['NEWS_URL'];
  print(pref.backendServer);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPref();
  await Firebase.initializeApp();
  await AppPalette.instance.init();
  await GetStorage.init();
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
        // home: BasicBottomNavBar(
        //   widget._ctx,
        //   index: 0,
        // ));
        home: SplashScreen(widget._ctx));
  }
}
