import 'package:http/http.dart' as http;

abstract class BBBaseClient {
  Future<dynamic> get(Uri uri) async {
    return http.get(uri);
  }

  Future<dynamic> post(Uri uri, dynamic payload) async {
    return http.post(uri, body: payload);
  }

  Future<dynamic> getHeaders(Uri uri, Map<String, String> headers) async {
    return http.get(uri, headers: headers);
  }
}
