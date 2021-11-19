import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';
import 'package:swifty/features/home/presentation/screens/Page_details/widgets/details_page_widget.dart';

import '../detail_page.dart';

class Header extends StatefulWidget {
  Function(String) changeCursusState;
  final UserInfo userInfo;
  Header({Key key, this.userInfo, this.changeCursusState}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(
              "https://cdn.intra.42.fr/coalition/cover/72/low-poly-texture-18_copy.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 40,
          ),
          dropDawn(widget.changeCursusState),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(widget.userInfo.imageUrl),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.userInfo.email,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.grade,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // Text((cursusdetails.grade == null)
                        //     ? ''
                        //     : cursusdetails.grade.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.map_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text((widget.userInfo.location == null)
                            ? 'Unavailable'
                            : widget.userInfo.location.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.local_atm_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          (widget.userInfo.wallet == null)
                              ? ''
                              : widget.userInfo.wallet.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LinearPercentIndicator(
              //   width: MediaQuery.of(context).size.width - 10,
              //   animation: true,
              //   lineHeight: 20.0,
              //   animationDuration: 1500,
              //   percent: (cursusdetails.level % 1),
              //   center: Text("${cursusdetails.level}%"),
              //   linearStrokeCap: LinearStrokeCap.roundAll,
              //   progressColor: Colors.blueAccent,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dropDawn(Function(String) changeCursusState) {
    return DropdownButton<String>(
      value: widget.userInfo.pickedCursus,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (newValue) {
        changeCursusState(newValue);
      },
      items:
          <String>['0', '1', '2'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

SliverAppBar sliverAppBar(userInfo, Function(String) changeCursusState) {
  return SliverAppBar(
    title: Center(
      child: Text(userInfo.login,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "greycliff-cf-regular")),
    ),
    expandedHeight: 300.0,
    floating: false,
    pinned: true,
    snap: false,
    elevation: 50,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      background:
          Header(userInfo: userInfo, changeCursusState: changeCursusState),
    ),
  );
}
