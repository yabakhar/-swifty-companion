import 'package:flutter/material.dart';
import 'dart:io';
import 'features/home/presentation/screens/login_page.dart';
import 'features/home/presentation/services/get_token.dart';

import 'package:swifty/features/home/presentation/models/stock_token.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOnline;

  void getToken() async {
    await Gettoken().gettoken();
    print(stock_token.access_token);
  }

  @override
  void initState() {
    super.initState();
    hasNetwork();
  }

  void hasNetwork() async {
    try {
      print("ana hna ========================>");
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        getToken();
      }
    } on SocketException catch (e) {
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swifty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
