import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:wartec_app/json/response.dart';
import 'package:wartec_app/models/credential.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:http/http.dart' as http;
import 'package:wartec_app/services/prefs.dart';

class HTTPService {
  final AppContext appContext;
  final Pref _;

  HTTPService(AppContext this.appContext) : _ = Pref();

  Future<http.Response> get(String url,
      {Map<String, String>? headers, bool? useCache = false}) async {
    await _.init();
    if (headers == null) {
      headers = Map<String, String>();
    }

    final fullUrl = '${_.backendServer}/$url';
    final key = 'http-${fullUrl}';
    final now = DateTime.now();
    if (_.backendServer != null && _.backendServer!.contains("localhost")) {
      print(fullUrl);
      return responseHandler(url);
    }
    if (useCache != null && useCache == true) {
      final cached = GetStorage().read(key);
      if (cached != null) {
        final expiry =
            DateTime.fromMicrosecondsSinceEpoch(cached['expiry'] as int);
        if (now.isAfter(expiry)) {
          GetStorage().remove(key);
        } else {
          return cached['response'] as Future<http.Response>;
        }
      }
    }

    final resp = appContext.client.get(Uri.parse(fullUrl), headers: headers);
    if (useCache != null && useCache == true) {
      Map<String, dynamic> map = Map();
      map['expiry'] =
          DateTime.now().add(Duration(minutes: 5)).microsecondsSinceEpoch;
      map['response'] = resp;
      GetStorage().write(key, map);
    }

    return resp;
  }

  Future<http.Response> getWithAuth(String url,
      {Map<String, String>? headers, bool? useCache = false}) async {
    await _.init();
    if (headers == null) {
      headers = Map<String, String>();
    }

    final fullUrl = '${_.backendServer}/$url';
    final key = 'http-${fullUrl}';
    final now = DateTime.now();

    if (useCache != null && useCache == true) {
      final cached = GetStorage().read(key);
      if (cached != null) {
        final expiry =
            DateTime.fromMicrosecondsSinceEpoch(cached['expiry'] as int);
        if (now.isAfter(expiry)) {
          GetStorage().remove(key);
        } else {
          Future<http.Response> resp = cached['response'];
          final tempResp = await resp;
          if (tempResp.statusCode == 200) {
            return resp;
          }
        }
      }
    }
    // headers['Authorization'] = await appContext.auth.getToken();
    print(fullUrl);

    final resp = appContext.client.get(Uri.parse(fullUrl), headers: headers);
    if (useCache != null && useCache == true) {
      Map<String, dynamic> map = Map();
      map['expiry'] =
          DateTime.now().add(Duration(minutes: 5)).microsecondsSinceEpoch;
      map['response'] = resp;
      GetStorage().write(key, map);
    }

    return resp;
  }

  Future<http.Response> post(String url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    await _.init();
    if (headers == null) {
      headers = Map<String, String>();
      headers['Content-Type'] = 'application/json; charset=UTF-8';
    }

    final fullUrl = '${_.backendServer}/$url';
    if (_.backendServer != null && _.backendServer!.contains("localhost")) {
      print(fullUrl);
      if (url == "api/user-login") {
        print(body);
        return loginHandler(body);
      }
    }
    // headers['Authorization'] = await appContext.auth.getToken();
    // _curl(fullUrl, 'POST', headers, body);

    return appContext.client.post(Uri.parse(fullUrl),
        headers: headers, body: body, encoding: encoding);
  }
}

loginHandler(String? bodyString) {
  final a = Credential.fromJson(json.decode(bodyString!));
  final b = Credential.fromJson(json.decode(credential));
  print(a.password);
  print(b.password);
  if (a.email == b.email && a.password == b.password) {
    return http.Response(news, 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
  } else
    return http.Response("""{"message": "user-not-found"}""", 404,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
}
