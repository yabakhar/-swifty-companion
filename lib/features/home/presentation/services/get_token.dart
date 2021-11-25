import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:swifty/const/keys.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';

class Gettoken {
  Future<void> gettoken() async {
    final client = RetryClient(http.Client());
    try {
      final response = await client.post(
          Uri.parse('https://api.intra.42.fr/oauth/token'),
          body: bodytoken);

      if (response.statusCode == 200) {
        Map<String, dynamic> info = json.decode(response.body);
        stock_token.access_token = info['access_token'];
        stock_token.expires_in = info['expires_in'];
      } else {
        throw Exception('chi haja machi s7i7a');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
  }

  Map<String, String> bodytoken = {
    'grant_type': 'client_credentials',
    'client_id': UID,
    'client_secret': SECRET,
  };
}
