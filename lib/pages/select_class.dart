import 'package:flutter/material.dart';
import 'package:senior_project/Widgets/course_widget.dart';
import 'package:senior_project/models/course.dart';
import 'package:senior_project/models/lecturer.dart';
import 'package:senior_project/models/section.dart';

class SelectClass extends StatefulWidget {
  const SelectClass({
    super.key,
  });

  @override
  State<SelectClass> createState() => _SelectClassState();
}

List<Section>? sections1 = [
  Section("IT1", "TRU", "13:00 - 14:40"),
  Section("IT2", "TRU", "13:00 - 14:40"),
  Section("IT3", "TRU", "13:00 - 14:40"),
];
List<Section>? sections2 = [
  Section("IT1", "TRU", "13:00 - 14:40"),
  Section("IT2", "TRU", "13:00 - 14:40"),
];

class _SelectClassState extends State<SelectClass> {
  List<Course>? courses = [
    Course("CPIT 101", sections1!),
    Course("CPIT 201", sections2!)
  ];
  Lecturer? lecturer = Lecturer('Motasem Aljarah', 'id', 'image');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(10),
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        title: Text("Welcome, Dr. ${lecturer?.name!}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Courses"),
          ),
          const SizedBox(
            height: 20,
          ),
          for (int i = 0; i < courses!.length; i++)
            Expanded(
              child: CourseWidget(course: courses![i]),
            ),
        ],
      ),
    );
  }
}
