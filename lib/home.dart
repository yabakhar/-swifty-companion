import 'package:flutter/material.dart';
import 'package:swifty/skilles.dart';

import 'detail_page.dart';
import 'get_user_data.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> info;
  bool _validate = false;
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
              onChanged: (value) {
                setState(() {
                  _validate = false;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter The Login',
                errorText: _validate ? 'Login Not Found' : null,
                hintText: 'Login',
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              info = await GetUserData().getUsers(searchController.text);

              if (info == null) {
                print("ana hna");
                setState(() {
                  _validate = true;
                });
              } else {
                print("ana hnas");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail_page(info: info)),
                );
              }
            },
            child: Text("Submit"),
          ),
          // RaisedButton(
          //   onPressed: () async {
          //     info = await GetUserData().getUsers("achaoua");
          //     Navigator.push(
          //       context,
                // MaterialPageRoute(builder: (context) => Skilles(info: info)),
          //     );
          //   },
          //   child: Text("Suddbmit"),
          // ),
        ],
      ),
    );
  }
}
