import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:swifty/const/keys.dart';
import 'package:swifty/features/home/presentation/models/simple_preferences.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';

class Gettoken {
  Map<String, String> bodytoken(String code) {
    return {
      'grant_type': 'authorization_code',
      'client_id': UID,
      'client_secret': SECRET,
      'code': code,
      'state': '456',
      'redirect_uri': URL
    };
  }

  Future<Response> get_oauth_token(String code) async {
    final client = RetryClient(http.Client());
    final response = await client.post(
        Uri.parse('https://api.intra.42.fr/oauth/token'),
        body: bodytoken(code));
    return response;
  }

  Future<stock_token> gettoken(
      String code, stock_token cachedToken, bool expiredToken) async {
    final client = RetryClient(http.Client());
    try {
      if (cachedToken == null || expiredToken == true) {
        Response response = await get_oauth_token(code);
        if (response.statusCode == 200) {
          Map<String, dynamic> info = json.decode(response.body);
          stock_token tokenInfo = stock_token.fromJson(info);
          SimplePreferences.setToken(tokenInfo);
          return tokenInfo;
        } else {
          throw Exception();
        }
      } else {
        return (cachedToken);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
  }
}
