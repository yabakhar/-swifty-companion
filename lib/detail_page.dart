import 'package:flutter/material.dart';
import 'package:swifty/projectcard.dart';
import 'package:swifty/projects_users.dart';
import 'cursus_details.dart';
import 'user_info.dart';

class Detail_page extends StatefulWidget {
    Map info;
  Detail_page({ this.info ,  key }) : super(key: key);
  @override
  _Detail_pageState createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {
  UserInfo userInfo;
  List<SkillsDetails> skillsDetails;
  CursusDetails cursusdetails;
  List<ProjectsUsers> projectsUsers;

  UserInfo parseInfo(){
    setState(() {
        projectsUsers = widget.info['projects_users'].map<ProjectsUsers>((e) => ProjectsUsers.fromJson(e)).toList();
        userInfo  = UserInfo.fromJson(widget.info);
        cursusdetails = CursusDetails.fromJson(widget.info['cursus_users'][0]);
        skillsDetails = widget.info['cursus_users'][0]['skills'].map<SkillsDetails>((e) => SkillsDetails.fromJson(e)).toList();
        });
  }

  void initState() {
    super.initState();
    parseInfo();
    // print(cursusdetails.grade.toString());
    // print(cursusdetails.level.toString());
    // print(userInfo.toString());
    // print(cursusdetails.level.toString());
    // projectsUsers.forEach((element) {
    //   print(element.project.name.toString());
    //   print(element.status.toString());
    //   print(element.finalMark.toString());
    //   print(element.validated.toString());
    //   print("=============>>");
    // });
    // skillsDetails.forEach((element) {
    //   print(element.id.toString());
    //   print(element.name.toString());
    //   print(element.level.toString());
    //   print("=============>>");
    // });
  }
@override
  Widget build(BuildContext context) {
    return new Scaffold(
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Center(
                        child: Text(userInfo.login,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "greycliff-cf-regular")),
                      ),
                      expandedHeight: 350.0,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 50,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: header(),
                      ),
                    ),
                    SliverList(
                        delegate: new SliverChildListDelegate(
                            _buildListPost(projectsUsers))),
                  ],
                ),
              ],
            ),
          );
        }
    List _buildListPost(List<ProjectsUsers> projectsUsers) {
    List<Widget> listItems = [];
    for (int i = 0; i < projectsUsers.length; i++) {
      listItems.add(InkWell(
          child: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: ProjectCard(projectsUsers:projectsUsers[i]),
      )));
    }
    return listItems;
  }
    Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 60.0,
           backgroundImage: NetworkImage(userInfo.imageUrl),
          backgroundColor: Colors.transparent,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [          
            Text(userInfo.email),
            Text(cursusdetails.grade.toString()),
            Text(userInfo.location),
            Text(userInfo.wallet.toString()),
          ],
        )
      ],
    );
    
  }
}

