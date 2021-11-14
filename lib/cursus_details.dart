class CursusDetails {
  String grade;
  double level;
  CursusDetails();
  CursusDetails.fromJson(Map<String, dynamic> json)
      : grade = json['grade'],
        level = json['level'];
}
