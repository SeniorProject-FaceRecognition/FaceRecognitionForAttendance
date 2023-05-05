import 'package:flutter/material.dart';
import 'package:senior_project/models/Section.dart';
import 'package:senior_project/models/lecturer.dart';

class SelectClass extends StatefulWidget {
  const SelectClass({
    super.key,
  });

  @override
  State<SelectClass> createState() => _SelectClassState();
}

class _SelectClassState extends State<SelectClass> {
  Lecturer? lecturer = Lecturer('Motasem Aljarah', 'id', 'image');

  List<Section> sections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(10),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        title: Text("Welcome,${lecturer?.name!}"),
      ),
    );
  }
}
