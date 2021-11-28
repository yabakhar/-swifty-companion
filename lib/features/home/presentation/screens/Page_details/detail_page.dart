import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/models/cursus_details.dart';
import 'package:swifty/features/home/presentation/models/projects_users.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';
import 'package:swifty/features/home/presentation/screens/Page_details/widgets/header.dart';
import 'package:swifty/features/home/presentation/screens/Page_details/widgets/projectcard.dart';
import 'package:swifty/features/home/presentation/screens/skilles_page.dart';

class Detail_page extends StatefulWidget {
  Map info;

  Detail_page({this.info, key}) : super(key: key);
  @override
  _Detail_pageState createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {
  UserInfo userInfo;
  int jj = 0;
  List<Cursus> cursus = [];
  List<String> ss = [];
  List<CursusDetails> cursusdetails;
  Map<String, int> dropDownValue = {};
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
      filldropDown();
      userInfo.pickedCursus = (cursus.isEmpty) ? "" : cursus[0].name;
    });
  }

  void filldropDown() {
    cursusdetails.forEach((element) {
      cursus.add(element.cursus);
    });
    cursus.toSet();
    cursus.forEach((element) {
      dropDownValue[element.name] = element.id;
      ss.add(element.name);
    });
  }

  void changeCursusState(String newValue) {
    setState(() {
      userInfo.pickedCursus = newValue;
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
            child: TabBarView(children: [
              CustomScrollView(
                slivers: <Widget>[
                  sliverAppBar(userInfo, changeCursusState,
                      getIndexCursus(userInfo.pickedCursus), ss,context),
                  SliverList(
                    
                      delegate: new SliverChildListDelegate(
                      
                          _buildListPost(projectsUsers))),
                ],
              ),
              Skilles(
                  skillsDetails: getIndexCursus(userInfo.pickedCursus)?.skills),
            ])));
  }

  CursusDetails getIndexCursus(String value) {
    setState(() {
      jj = cursusdetails.indexWhere((element) => element.cursus.name == value);
    });
    if (jj < 0) return (null);
    return (cursusdetails[jj]);
  }

  List _buildListPost(List<ProjectsUsers> projectsUsers) {
    List<Widget> listItems = [];
    for (int i = 0; i < projectsUsers.length; i++) {
      if (projectsUsers[i].cursusIds.contains(dropDownValue[userInfo.pickedCursus])) {
        listItems.add(InkWell(
            child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: ProjectCard(projectsUsers: projectsUsers[i]),
        )));
      }
    }
    return listItems;
  }
}
