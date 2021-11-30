import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:swifty/const/Keys.dart';

class GetAutorized {
  Future<String> authenticate() async {
    final result = await FlutterWebAuth.authenticate(
        url: urlfactory(), callbackUrlScheme: "swifty");
    final code = Uri.parse(result).queryParameters['code'];
    return (code);
  }

  String urlfactory() {
    return ENDPOINT_URL + '?' + Uri(queryParameters: queryparams).query;
  }

  Map<String, String> queryparams = {
    "client_id": UID,
    "redirect_uri": URL,
    "scope": "public",
    "state": "41657",
    "response_type": "code"
  };
}
