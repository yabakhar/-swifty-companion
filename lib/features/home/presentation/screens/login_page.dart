import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/services/get_user_data.dart';
import 'Page_details/detail_page.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map<String, dynamic> info;

  bool _validate = false;
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<bool> loginAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
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
                setState(() {
                  _validate = true;
                });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                await loginAction();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail_page(info: info)),
                );
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
