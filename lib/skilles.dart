import 'package:flutter/material.dart';
import 'package:swifty/user_info.dart';

class Skilles extends StatefulWidget {
  Map info;
  Skilles({this.info, key}) : super(key: key);

  @override
  _SkillesState createState() => _SkillesState();
}

class _SkillesState extends State<Skilles> {
  List<SkillsDetails> skillsDetails;
  List<String> name;
  List<Widget> dd;
  List<double> levle;
  double max_value = 0;
  UserInfo parseInfo() {
    setState(() {
      skillsDetails = widget.info['cursus_users'][0]['skills']
              .map<SkillsDetails>((e) => SkillsDetails.fromJson(e))
              .toList() ??
          [];
    });
  }

  void initState() {
    super.initState();
    parseInfo();
    levle = List<double>();
    name = List<String>();
    dd = List<Widget>();

    print(skillsDetails.length);
    skillsDetails.forEach((element) {
      dd.add(cc(element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Skills", textAlign: TextAlign.center)),
      ),
      body: Center(
        child: Wrap(
          spacing: 6.0,
          runSpacing: 7.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: dd,
        ),
      ),
    );
  }
}

Widget cc(SkillsDetails element) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
    ),
    height: 120,
    width: 100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          element.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "greycliff-cf-regular"),
        ),
        Text(
          element.level.toString(),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
