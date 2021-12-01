import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty/const/images.dart';
import 'package:swifty/features/home/presentation/models/cursus_details.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';
import 'package:swifty/features/home/presentation/services/image_profile_validate.dart';

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
  @override
  Widget build(BuildContext context) {
    TextStyle _textStyleValue = TextStyle(
        color: Colors.grey[50], fontSize: 14, fontWeight: FontWeight.w700);
    TextStyle _textStyleItems = TextStyle(
        color: Colors.blue[100], fontSize: 14, fontWeight: FontWeight.w700);
    double level = (widget.cursusDetails?.level == null)
        ? 0.0
        : widget.cursusDetails.level;
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            height: MediaQuery.of(context).size.height / 4.5,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Grade", style: _textStyleItems),
                    Text(
                      (widget.cursusDetails?.grade == null)
                          ? '-'
                          : widget.cursusDetails?.grade.toString(),
                      style: _textStyleValue,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Location", style: _textStyleItems),
                    Text(
                      (widget.userInfo.location == null)
                          ? 'Unavailable'
                          : widget.userInfo.location.toString(),
                      style: _textStyleValue,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Wallet", style: _textStyleItems),
                    Text(
                      (widget.userInfo.wallet == null)
                          ? ''
                          : (widget.userInfo.wallet.toString() + " ₳"),
                      style: _textStyleValue,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Cursus", style: _textStyleItems),
                    dropDown(widget.changeCursusState),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Grade", style: _textStyleItems),
                    Text(
                      widget.userInfo.email,
                      style: _textStyleValue,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Widget dropDown(Function(String) changeCursusState) {
    return Container(
      height: 20,
      child: DropdownButton<String>(
        value: widget.userInfo.pickedCursus,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
        iconSize: 24,
        elevation: 8,
        style: const TextStyle(color: Colors.blue),
        underline: Container(),
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
      ),
    );
  }
}

SliverAppBar sliverAppBar(userInfo, Function(String) changeCursusState,
    cursusDetails, dropDownValue, context) {
  return SliverAppBar(
    title: Center(
      child: Text(userInfo.login,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "greycliff-cf-regular")),
    ),
    expandedHeight: MediaQuery.of(context).size.height / 2.5,
    floating: false,
    pinned: true,
    snap: false,
    actions: [
      InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color(0xff3e5770),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Color(0xff3a305b),
                      )),
                  content: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      FutureBuilder<String>(
                          future: getImageUrl(userInfo.imageUrl),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(snapshot.data);
                            } else if (snapshot.hasError) {
                              return Image(image: AssetImage(avatar));
                            }
                            return CircularProgressIndicator();
                          }),
                    ],
                  ),
                );
              });
        },
        child: FutureBuilder<String>(
            future: getImageUrl(userInfo.imageUrl),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      snapshot.data,
                    ));
              } else if (snapshot.hasError) {
                return CircleAvatar(
                    radius: 25.0, backgroundImage: AssetImage(avatar));
              }
              return CircularProgressIndicator();
            }),
      ),
    ],
    elevation: 50,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3a305b),
            Color(0xff3e5770),
          ],
        ),
      ),
      child: FlexibleSpaceBar(
        centerTitle: true,
        background: Header(
            userInfo: userInfo,
            dropDowwnValue: dropDownValue,
            changeCursusState: changeCursusState,
            cursusDetails: cursusDetails),
      ),
    ),
  );
}
