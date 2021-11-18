import 'package:flutter/material.dart';
import 'package:swifty/projectcard.dart';
import 'package:swifty/projects_users.dart';
import 'package:swifty/skilles.dart';
import 'cursus_details.dart';
import 'user_info.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Detail_page extends StatefulWidget {
  Map info;
  Detail_page({this.info, key}) : super(key: key);
  @override
  _Detail_pageState createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {
  UserInfo userInfo;
  List<CursusDetails> cursusdetails;
  List<ProjectsUsers> projectsUsers;
  UserInfo parseInfo() {
    setState(() {
      projectsUsers = widget.info['projects_users']
          .map<ProjectsUsers>((e) => ProjectsUsers.fromJson(e))
          .toList();
      userInfo = UserInfo.fromJson(widget.info);
      cursusdetails = widget.info['cursus_users']
          .map<CursusDetails>((e) => CursusDetails.fromJson(e))
          .toList();
    });
  }

  void initState() {
    super.initState();
    parseInfo();
  }

  SliverAppBar _sliverAppBar() {
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
        background: header(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: DefaultTabController(
            length: 2,
            child: TabBarView(children: [
              CustomScrollView(
                slivers: <Widget>[
                  _sliverAppBar(),
                  SliverList(
                      delegate: new SliverChildListDelegate(
                          _buildListPost(projectsUsers))),
                ],
              ),
              Skilles(info: widget.info),
            ])));
  }

  List _buildListPost(List<ProjectsUsers> projectsUsers) {
    List<Widget> listItems = [];
    for (int i = 0; i < projectsUsers.length; i++) {
      listItems.add(InkWell(
          child: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: ProjectCard(projectsUsers: projectsUsers[i]),
      )));
    }
    return listItems;
  }

  Widget header() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(userInfo.imageUrl),
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
                          userInfo.email,
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
                        Text((userInfo.location == null)
                            ? 'Unavailable'
                            : userInfo.location.toString()),
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
                          (userInfo.wallet == null)
                              ? ''
                              : userInfo.wallet.toString(),
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
}
//https://pub.dev/packages/multi_charts
