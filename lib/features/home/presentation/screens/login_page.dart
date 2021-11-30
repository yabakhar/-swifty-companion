import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/services/get_user_data.dart';
import 'Page_details/detail_page.dart';
import 'package:progress_state_button/progress_button.dart';

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
          // Container(
          //   child: ProgressButton(
          //     stateWidgets: {
          //       ButtonState.idle: Text(
          //         "Idle",
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.w500),
          //       ),
          //       ButtonState.loading: Text(
          //         "Loading",
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.w500),
          //       ),
          //       ButtonState.fail: Text(
          //         "Fail",
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.w500),
          //       ),
          //       ButtonState.success: Text(
          //         "Success",
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.w500),
          //       )
          //     },
          //     stateColors: {
          //       ButtonState.idle: Colors.grey.shade400,
          //       ButtonState.loading: Colors.blue.shade300,
          //       ButtonState.fail: Colors.red.shade300,
          //       ButtonState.success: Colors.green.shade400,
          //     },
          //     // onPressed: onPressed,
          //     state: ButtonState.idle,
          //   ),
          // ),
          RaisedButton(
            onPressed: () async {
              await onPrddessed();
            },

            // onPressed: () async {
            //   info = await GetUserData().getUsers(searchController.text);
            //   if (info == null) {
            //     setState(() {
            //       _validate = true;
            //     });
            //   } else {
            //     showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         });
            //     await loginAction();
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => Detail_page(info: info)),
            //     );
            //   }
            // },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  Future<void> onPrddessed() async {
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
        MaterialPageRoute(builder: (context) => Detail_page(info: info)),
      );
    }
  }
}
