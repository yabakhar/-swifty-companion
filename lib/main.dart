import 'package:flutter/material.dart';

import 'features/home/presentation/models/simple_preferences.dart';
import 'features/home/presentation/screens/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SimplePreferences.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOnline;
  @override
  void initState() {
    super.initState();
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
