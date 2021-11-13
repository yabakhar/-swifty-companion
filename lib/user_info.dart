class UserInfo {
  String login;
  String email;
  String location;
  String image_url;
  // String level;
  UserInfo();
  UserInfo.fromJson(Map<String, dynamic> json): login = json['login'],email = json['email'],location = json['location'],image_url = json['image_url'];
}