import 'dart:async';
import 'dart:ui';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:swifty/const/images.dart';
import 'package:swifty/features/home/presentation/services/get_user_data.dart';
import 'Page_details/detail_page.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _validate = false;
  bool _connection = false;
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<bool> checkConniction() async {
    bool result = await DataConnectionChecker().hasConnection;
    setState(() {
      _validate = false;
    });
    if (result == true) {
      return result;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
      return result;
    }
  }

  Future<bool> loginAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyleValue = TextStyle(
        color: Color(0xff3a305b), fontSize: 14, fontWeight: FontWeight.w700);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage(background),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(logo42),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  style: _textStyleValue,
                  cursorColor: Color(0xff3a305b),
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      _validate = false;
                    });
                  },
                  autocorrect: false,
                  decoration: InputDecoration(
                      filled: true,
                    fillColor: Colors.white38,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff3a305b)),
                    border: OutlineInputBorder(),
                    labelText: 'Enter The Login',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3e5770),
                    ),
                    errorText: _validate ? 'Login Not Found' : null,
                    hintText: 'Login',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              TextButton(
                child: Text("Search".toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue, width: 2)))),
                onPressed: () => searchLogin(),
              ),
            ],
          ),
        ));
  }

  Future<void> searchLogin() async {
    if (await checkConniction() == true) {
      final info = await GetUserData().getUsers(searchController.text);
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
}
