import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:swifty/features/home/presentation/models/stock_token.dart';

class SimplePreferences {
  static SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setToken(stock_token stocktoken) async {
    return await _preferences.setString(
        "token", json.encode(stocktoken.tojson()));
  }

  static Future<stock_token> getCachedToken() async {
    final jsonString = _preferences.getString("token");
    if (jsonString != null) {
      return stock_token.fromJson(json.decode(jsonString));
    }
    return (null);
  }
}
