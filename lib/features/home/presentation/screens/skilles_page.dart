import 'package:flutter/material.dart';
import 'package:swifty/features/home/presentation/models/user_info.dart';

class Skilles extends StatefulWidget {
  final List<SkillsDetails> skillsDetails;
  Skilles({this.skillsDetails, key}) : super(key: key);

  @override
  _SkillesState createState() => _SkillesState();
}

class _SkillesState extends State<Skilles> {
  List<Widget> cells;
  void initState() {
    super.initState();
    cells = List<Widget>();
    if (widget.skillsDetails != null) {
      widget.skillsDetails.forEach((element) {
        cells.add(cellsCard(element));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff3a305b),
                Color(0xff3e5770),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Center(child: Text("Skills", textAlign: TextAlign.center)),
      ),
      body: Center(
        child: (cells.length > 0) ? Wrap(
          spacing: 6.0,
          runSpacing: 7.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: cells,
        ):Text("Nothing To Show"),
      ),
    );
  }
}

Widget cellsCard(SkillsDetails element) {
  double level = (element?.level == null) ? 0.0 : element.level;
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.blue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
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
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontFamily: "greycliff-cf-regular"),
        ),
        Text(
          level.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
