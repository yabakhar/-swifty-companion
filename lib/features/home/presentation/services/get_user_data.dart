import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:swifty/features/home/presentation/models/simple_preferences.dart';
import 'package:swifty/features/home/presentation/services/get_autorized.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';
import 'package:swifty/features/home/presentation/services/get_token.dart';

class GetUserData {
  GetAutorized getAutorized = GetAutorized();
  Map<String, String> headerInfo(String access_token) => {
        'Authorization': 'Bearer ' + access_token,
      };

  Future<String> getAuthenticate() async {
    return await getAutorized.authenticate();
  }

  bool checkExistAndExpiredToken(stock_token access_token) {
    DateTime currentPhoneDate = DateTime.now();
    if (access_token != null) {
      var time_experation =
          DateTime.fromMillisecondsSinceEpoch(access_token.created_at * 1000);
      time_experation =
          time_experation.add(Duration(seconds: access_token.expires_in));
      return currentPhoneDate.isAfter(time_experation);
    }
    return false;
  }

  Future<Map> getUsers(String login) async {
    stock_token access_token;
    final client = RetryClient(http.Client());
    try {
      stock_token cachedToken = await SimplePreferences.getCachedToken();
      bool expiredToken = checkExistAndExpiredToken(cachedToken);
      if (cachedToken == null ||
          checkExistAndExpiredToken(cachedToken) == true) {
        String code = await getAuthenticate();
        access_token =
            await Gettoken().gettoken(code, cachedToken, expiredToken);
        cachedToken = access_token;
      }
      final response = await client.get(
          Uri.parse('https://api.intra.42.fr/v2/users/' + login),
          headers: headerInfo(cachedToken.access_token));
      if (response.statusCode == 200) {
        Map<String, dynamic> info = json.decode(response.body);
        return (info);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
  }
}
