import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';

class Skilles extends StatefulWidget {
  final List<SkillsDetails> skillsDetails;
  Skilles({this.skillsDetails, key}) : super(key: key);

  @override
  _SkillesState createState() => _SkillesState();
}

class _SkillesState extends State<Skilles> {
  List<Widget> dd;
  void initState() {
    super.initState();
    dd = List<Widget>();
    widget.skillsDetails.forEach((element) {
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
