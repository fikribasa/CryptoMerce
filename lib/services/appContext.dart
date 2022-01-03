import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:wartec_app/models/userInfo.dart';
import 'package:wartec_app/services/authService.dart';
import 'package:wartec_app/services/services.dart';
import 'package:wartec_app/utils/storage.dart';

class AppContext extends State<StatefulWidget> {
  late http.Client client;
  late final API api;
  UserModel? user;
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

  Future<void> logout() async {
    await Auth().signOut();
    await storage.erase();
    user = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
