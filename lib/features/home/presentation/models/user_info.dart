class UserInfo {
  String pickedCursus;
  String login;
  String email;
  String location;
  String imageUrl;
  int wallet;
  UserInfo();
  UserInfo.fromJson(Map<String, dynamic> json)
      : login = json['login'],
        email = json['email'],
        location = json['location'],
        imageUrl = json['image_url'],
        wallet = json['wallet'];
  SkillsDetails skillsDetails;
}

class SkillsDetails {
  int id;
  String name;
  double level;
  SkillsDetails();
  SkillsDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        level = json['level'];
}

class Cursus {
  int id;
  String name;
  Cursus();
  Cursus.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
