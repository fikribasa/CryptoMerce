import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:wartec_app/services/services.dart';

class AppContext extends State<StatefulWidget> {
  late http.Client client;
  late final API api;
  // String? userID;
  // User? user;
  GlobalKey<NavigatorState>? navigatorKey;

  RxBool isPatientValid = false.obs;

  static final AppContext _singleton = AppContext._internal();
  static AppContext get instance => _singleton;

  AppContext._internal() {
    // this.auth = AuthService();
    HttpClient c = HttpClient();
    c.connectionTimeout = const Duration(seconds: 60);

    c.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    client = IOClient(c);
    api = API(this);
  }

  // logout() async {
  //   PushNotificationsManager().fcmUnSubscribeAll();
  //   await auth.logout();
  //   patient = null;
  //   userID = '';
  //   isPatientValid.value = false;
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
