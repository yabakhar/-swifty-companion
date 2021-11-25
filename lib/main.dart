import 'package:flutter/material.dart';
import 'dart:io';
import 'features/home/presentation/screens/login_page.dart';
import 'features/home/presentation/services/get_token.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isOnline = false;
  void getToken() async {
    await Gettoken().gettoken();
    print(stock_token.access_token);
  }

  void hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) isOnline = true;
    } on SocketException catch (_) {
      isOnline = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (stock_token.access_token == null)
    // {
    hasNetwork();
    if (isOnline) getToken();
    // }

    print(isOnline.toString() + "============>");
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
