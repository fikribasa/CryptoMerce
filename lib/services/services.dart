import 'dart:convert';

import 'package:wartec_app/json/response.dart';
import 'package:wartec_app/models/credential.dart';
import 'package:wartec_app/models/headlines.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/models/userInfo.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/services/http.dart';

class API extends HTTPService {
  API(AppContext ctx) : super(ctx);

  Future userLogin(String username, String password) async {
    try {
      final url = 'api/user-login';
      final _body = Credential(email: username, password: password);
      var response = await post(url, body: json.encode(_body.toJson()));
      print(response.statusCode);

      return Future.value(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(null);
  }

  Future<UserModel?> getUserInfo() async {
    try {
      final url = 'api/user-info';
      var response = await get(url);
      print(response.statusCode);
      final newsHeadline = UserModel.fromJson(json.decode(response.body));
      return Future.value(newsHeadline);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(UserModel());
  }

  Future<Headlines?> getNewsHeadlines() async {
    try {
      final url = 'api/news';
      var response = await get(url, useCache: true);
      print(response.statusCode);
      final newsHeadline = Headlines.fromJson(json.decode(response.body));
      return Future.value(newsHeadline);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(Headlines());
  }

  Future<TokenList?> getTokenList() async {
    try {
      final url = 'api/token-list';
      var response = await get(url, useCache: true);
      final tokenList = TokenList.fromJson(json.decode(response.body));
      return Future.value(tokenList);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(TokenList());
  }
}
