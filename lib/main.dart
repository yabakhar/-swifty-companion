import 'package:flutter/material.dart';

import 'features/home/presentation/screens/login_page.dart';
import 'features/home/presentation/services/get_token.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void pintToken() async {
    await Gettoken().gettoken();
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
