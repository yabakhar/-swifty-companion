import 'package:swifty/features/home/presentation/models/user_info.dart';
class CursusDetails {
  String grade;
  double level;
  List<SkillsDetails> skills;
  CursusDetails();
  Cursus cursus;
  CursusDetails.fromJson(Map<String, dynamic> json) {
    grade = json['grade'];
    level = json['level'];
    cursus =
        json['cursus'] != null ? new Cursus.fromJson(json['cursus']) : null;
    skills = json['skills']
        .map<SkillsDetails>((e) => SkillsDetails.fromJson(e))
        .toList();
  }
}
