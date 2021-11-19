import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swifty/features/home/presentation/models/projects_users.dart';

class ProjectCard extends StatefulWidget {
  ProjectsUsers projectsUsers;
  ProjectCard({this.projectsUsers, key}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  String iconKey;
  void initState() {
    super.initState();
    iconKey = iconValidate(widget.projectsUsers);
    if (widget.projectsUsers.finalMark == null &&
        widget.projectsUsers.status == "finished") iconKey = "failed";
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> icons = {
      "in_progress": Icon(Icons.timelapse, color: Colors.orange),
      "waiting_for_correction": Icon(Icons.timelapse, color: Colors.orange),
      "searching_a_group": Icon(Icons.timelapse, color: Colors.orange),
      "parent": Icon(Icons.timelapse, color: Colors.orange),
      "failed": Icon(Icons.dangerous, color: Colors.red),
      "creating_group": Icon(Icons.timelapse, color: Colors.orange),
      "valid": Text(widget.projectsUsers.finalMark.toString())
    };
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(6.0)),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Text((widget.projectsUsers.project.name != null)
                      ? widget.projectsUsers.project.name
                      : "-"),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    (widget.projectsUsers.status != null)
                        ? widget.projectsUsers.status
                        : "-",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.centerRight, child: icons[iconKey]),
              ),
            ],
          ),
          Row(children: [
            Text(
              widget.projectsUsers.project.slug,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
          ])
        ],
      ),
    );
  }
}

String iconValidate(ProjectsUsers projectsUsers) {
  if ((projectsUsers.status) == null || (projectsUsers.finalMark) == null) {
    return (projectsUsers.status);
  } else if (((projectsUsers.finalMark) == 0) &&
      (projectsUsers.status) == "finished") {
    return ("failed");
  } else if ((projectsUsers.finalMark > 0) &&
      (projectsUsers.status) == "finished") {
    return ("valid");
  } else
    return (projectsUsers.status);
}
