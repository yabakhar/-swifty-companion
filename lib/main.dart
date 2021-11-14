import 'package:flutter/material.dart';
import 'package:swifty/home.dart';
import 'package:swifty/stock_token.dart';

import 'get_user_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  void pintToken() async {
     await GetUserData().gettoken();
      print(stock_token.access_token);
  }
  
  @override
  Widget build(BuildContext context) {
    // if (stock_token.access_token == null)
    // {
      pintToken();
    // }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
