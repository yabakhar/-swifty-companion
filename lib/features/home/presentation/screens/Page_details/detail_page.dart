import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/models/cursus_details.dart';
import 'package:swifty/features/home/presentation/models/projects_users.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';
import 'package:swifty/features/home/presentation/screens/Page_details/widgets/details_page_widget.dart';
import 'package:swifty/features/home/presentation/screens/skilles_page.dart';
import 'package:swifty/features/home/presentation/screens/Page_details/widgets/projectcard.dart';
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: DefaultTabController(
        length: 2,
        child: TabBarView(
          children: [
            CustomScrollView(
            slivers: <Widget>[
              sliverAppBar(userInfo),
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
}


String dropdownValue = 'One';
Widget dropDown()
{
  return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        setState(() {
          dropdownValue = newValue;
        });
          },
          );
         },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
}