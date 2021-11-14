import 'package:flutter/widgets.dart';
import 'package:swifty/projects_users.dart';

class ProjectCard extends StatefulWidget {
  ProjectsUsers projectsUsers;
  ProjectCard({this.projectsUsers, key}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text((widget.projectsUsers.project.name != null)
              ? widget.projectsUsers.project.name
              : "-"),
          Text((widget.projectsUsers.status != null)
              ? widget.projectsUsers.status
              : "-"),
          Text((widget.projectsUsers.finalMark != null)
              ? widget.projectsUsers.finalMark.toString()
              : "-"),
        ],
      ),
    );
  }
}
