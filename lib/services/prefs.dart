import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  SharedPreferences? _;

  Pref();

  init() async {
    _ = await SharedPreferences.getInstance();
  }

  final _NEWS_URL = 'news-url';
  final _BACKEND_SERVER = 'backend-server';
  final _MODE = "PROD";

  String? get newsURL => _?.getString(_NEWS_URL);

  set newsURL(String? newsURL) {
    _?.setString(_NEWS_URL, newsURL ?? "");
  }

  String? get backendServer => _?.getString(_BACKEND_SERVER);

  set backendServer(String? host) {
    _?.setString(_BACKEND_SERVER, host ?? "");
  }

  set mode(String? mode) {
    _?.setString(_MODE, mode ?? "");
  }

  String? get mode => _?.getString(_MODE);
}

final pref = Pref();
