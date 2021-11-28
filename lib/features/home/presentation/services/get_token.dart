import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:swifty/const/keys.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';
import 'package:swifty/features/home/presentation/services/get_autorized.dart';

class Gettoken {
  GetAutorized getAutorized = GetAutorized();
  Future<void> gettoken() async {
    final code = await getAutorized.authenticate();
    Map<String, String> bodytoken = {
      'grant_type': 'authorization_code',
      'client_id': UID,
      'client_secret': SECRET,
      'code': code,
      'state': '456',
      'redirect_uri': URL
    };
    final client = RetryClient(http.Client());
    try {
      final response = await client.post(
          Uri.parse('https://api.intra.42.fr/oauth/token'),
          body: bodytoken);
      print(response.statusCode.toString() + "              ----------->");
      if (response.statusCode == 200) {
        Map<String, dynamic> info = json.decode(response.body);
        stock_token.access_token = info['access_token'];
        stock_token.expires_in = info['expires_in'];
        stock_token.autorized_token = code;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
  }
}
