import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:swifty/features/home/presentation/models/stock_token.dart';

class SimplePreferences {
  static SharedPreferences _preferences;
   static Future init()async => _preferences = await SharedPreferences.getInstance();
   static Future setToken(stock_token stocktoken)async => await _preferences.setString("key", json.encode(stocktoken));
   static Future getToken()async => await _preferences.setString("key", json.decode(_preferences.getString("key")));
}