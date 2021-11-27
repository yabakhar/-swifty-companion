import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty/const/avatar.dart';
import 'package:swifty/features/home/presentation/models/cursus_details.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';

class Header extends StatefulWidget {
  Function(String) changeCursusState;
  final List<String> dropDowwnValue;
  final CursusDetails cursusDetails;
  final UserInfo userInfo;
  Header(
      {Key key,
      this.userInfo,
      this.changeCursusState,
      this.cursusDetails,
      this.dropDowwnValue})
      : super(key: key);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _loadImageError = false;

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700);
    double level = (widget.cursusDetails?.level == null)
        ? 0.0
        : widget.cursusDetails.level;
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
                    backgroundImage: NetworkImage(
                        (widget.userInfo.imageUrl == null)
                            ? avatar
                            : widget.userInfo.imageUrl),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.userInfo.email,
                          style: _textStyle,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.mail,
                          color: Colors.purple[300],
                          size: 30,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.cursusDetails?.grade == null)
                              ? ''
                              : widget.cursusDetails?.grade.toString(),
                          style: _textStyle,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.grade,
                          color: Colors.purple[300],
                          size: 30,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.userInfo.location == null)
                              ? 'Unavailable'
                              : widget.userInfo.location.toString(),
                          style: _textStyle,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.map_rounded,
                          color: Colors.purple[300],
                          size: 30,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.userInfo.wallet == null)
                              ? ''
                              : widget.userInfo.wallet.toString(),
                          style: _textStyle,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.local_atm_outlined,
                          color: Colors.purple[300],
                          size: 30,
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
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 10,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 1500,
                percent: (level % 1),
                center: Text("${level.toStringAsFixed(2)}%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.blueAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dropDawn(Function(String) changeCursusState) {
    return DropdownButton<String>(
      value: widget.userInfo.pickedCursus,
      icon: const Icon(Icons.arrow_downward, color: Colors.blue),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (newValue) {
        changeCursusState(newValue);
      },
      items:
          widget.dropDowwnValue.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

SliverAppBar sliverAppBar(userInfo, Function(String) changeCursusState,
    cursusDetails, dropDownValue) {
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
      background: Header(
          userInfo: userInfo,
          dropDowwnValue: dropDownValue,
          changeCursusState: changeCursusState,
          cursusDetails: cursusDetails),
    ),
  );
}
