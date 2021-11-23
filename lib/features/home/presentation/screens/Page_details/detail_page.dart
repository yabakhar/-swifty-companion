import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/models/cursus_details.dart';
import 'package:swifty/features/home/presentation/models/projects_users.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';
import 'package:swifty/features/home/presentation/screens/Page_details/widgets/details_page_widget.dart';
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
  List<Cursus> cursus = [];
  List<CursusDetails> cursusdetails;
  Map<String, int> dropDownValue = {};
  static List ss = [];
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
      fillDropDawn();
      userInfo.pickedCursus = cursus[0].name;
    });
  }

  void fillDropDawn() {
    cursusdetails.forEach((element) {
      cursus.add(element.cursus);
    });
    cursus.toSet();
    cursus.forEach((element) {
      dropDownValue[element.name] = element.id;
      ss.add(element.name);
      print(element.name);
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
    print(getIndexCursus(userInfo.pickedCursus, cursus).toString() +
        "++++++++++++");
    return new Scaffold(
        body: DefaultTabController(
            length: 2,
            child: TabBarView(children: [
              CustomScrollView(
                slivers: <Widget>[
                  sliverAppBar(
                      userInfo,
                      changeCursusState,
                      cursusdetails[
                          getIndexCursus(userInfo.pickedCursus, cursus)]),
                  SliverList(
                      delegate: new SliverChildListDelegate(
                          _buildListPost(projectsUsers))),
                ],
              ),
              Skilles(
                  skillsDetails: cursusdetails[
                          getIndexCursus(userInfo.pickedCursus, cursus)]
                      .skills),
            ])));
  }

  int getIndexCursus(String value, List<Cursus> cursus) {
    int i = 0;
    cursus.forEach((element) {
      if (value == element.name) {
        return (i);
      }
      i++;
    });
    return (i);
  }

  List _buildListPost(List<ProjectsUsers> projectsUsers) {
    List<Widget> listItems = [];
    for (int i = 0; i < projectsUsers.length; i++) {
      if (projectsUsers[i].cursusIds[0] ==
          dropDownValue[userInfo.pickedCursus]) {
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
