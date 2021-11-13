import 'package:flutter/material.dart';
import 'user_info.dart';
class Detail_page extends StatefulWidget {
    Map info;
  Detail_page({ this.info ,  key }) : super(key: key);
  @override
  _Detail_pageState createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {
UserInfo userInfo;
  UserInfo parseInfo(){
    setState(() {
        userInfo  = UserInfo.fromJson(widget.info);
        });
     
  }

  void initState() {
    super.initState();
    parseInfo();
  }

  Map info;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
  backgroundImage: NetworkImage(userInfo.image_url),
),
            Text(userInfo.login),
            Text(userInfo.email),
            Text(userInfo.location),
          ],
        ),
      ),
    );
  }
}