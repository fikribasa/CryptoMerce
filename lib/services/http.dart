import 'package:get_storage/get_storage.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:http/http.dart' as http;

class HTTPService {
  final AppContext appContext;

  String? get backendUrl => "backendServer";

  HTTPService(AppContext this.appContext);

  Future<http.Response> get(String url,
      {Map<String, String>? headers, bool? useCache = false}) async {
    if (headers == null) {
      headers = Map<String, String>();
    }

    final fullUrl = '${backendUrl}/$url';
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
}
