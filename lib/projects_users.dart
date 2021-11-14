class ProjectsUsers {
  int finalMark;
  String status;
  List<int> cursusIds;
  Project project;
  ProjectsUsers();
    ProjectsUsers.fromJson(Map<String, dynamic> json) {
    finalMark = json['final_mark'];
    status = json['status'];
    project = json['project'] != null ? new Project.fromJson(json['project']) : null;
    cursusIds = json['cursus_ids'].cast<int>();
  }
}

class Project {
  String name;

  Project();

  Project.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}