import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:swifty/const/keys.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';
class GetUserData {
  Map<String, String> body = {
    'Authorization': 'Bearer ' + stock_token.access_token,
  };

  Future<Map> getUsers(String login) async {
    final client = RetryClient(http.Client());
    try {
      final response = await client.get(
          Uri.parse('https://api.intra.42.fr/v2/users/' + login),
          headers: body);
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
