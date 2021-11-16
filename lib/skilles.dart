

import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
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
  List<double> levle;
  double max_value = 0;
  UserInfo parseInfo() {
    setState(() {
        skillsDetails = widget.info['cursus_users'][0]['skills'].map<SkillsDetails>((e) => SkillsDetails.fromJson(e)).toList() ?? [];
      
    });
  }

  void initState() {
    super.initState();
    parseInfo();

    // print(widget.info.toString());
    // print(skillsDetails.toString());
    levle = List<double>();
    name = List<String>();

    skillsDetails.forEach((element) {
        levle.add(element.level);
        if (element.level >= max_value)
          max_value = element.level;
        name.add(element.name);
    });
     
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 100,
      color: Colors.amber,
      child: RadarChart(
              values: levle,
              labels: name,
              maxValue: max_value + 2,
              fillColor: Colors.blue,
              chartRadiusFactor: 0.8,
            ),
    );
  }
}