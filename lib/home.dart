import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'get_user_data.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> info;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              info = await GetUserData().getUsers(searchController.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail_page(info: info)),
              );
            },
            child: Text('TextButton'),
          ),
        ],
      ),
    );
  }
}
