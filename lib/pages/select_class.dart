import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/Widgets/course_widget.dart';
import 'package:senior_project/models/course.dart';
import 'package:senior_project/models/lecture.dart';
import 'package:senior_project/models/lecturer.dart';
import 'package:senior_project/models/section.dart';
import 'package:senior_project/pages/select_Lecture.dart';

import '../services/Authentication.dart';

class SelectClass extends StatefulWidget {
  const SelectClass({
    super.key,
  });

  @override
  State<SelectClass> createState() => _SelectClassState();
}

List<Lecture>? lectures1 = [
  Lecture(
    DateTime(2023, 5, 7, 13, 00),
    [],
  ),
  Lecture(
    DateTime(2023, 5, 7, 11, 00),
    [],
  ),
  Lecture(
    DateTime(2023, 5, 7, 15, 00),
    [],
  ),
  Lecture(
    DateTime(2023, 5, 10, 15, 00),
    [],
  ),
  Lecture(
    DateTime(2023, 5, 9, 15, 00),
    [],
  ),
  Lecture(
    DateTime(2023, 5, 8, 15, 00),
    [],
  ),
];

List<Section>? sections1 = [
  Section("IT1", "TRU", "13:00 - 14:40", []),
  Section("IT2", "TRU", "11:00 - 12:40", lectures1),
  Section("IT3", "TRU", "15:00 - 16:40", []),
];
List<Section>? sections2 = [
  Section("IT1", "MW", "13:00 - 14:40", []),
  Section("IT2", "MW", "15:00 - 16:40", []),
];

class _SelectClassState extends State<SelectClass> {
  List<Course>? courses = [
    Course("CPIT 101", sections1!),
    Course("CPIT 201", sections2!)
  ];
  Lecturer? lecturer = Lecturer('Motasem Aljarah', 'id', 'image');

  int sectionindex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
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
        actions: [
          IconButton(
              onPressed: () async {
                auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
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
              child: CourseWidget(
                course: courses![i],
                onSelectParam: (p0) {
                  sectionindex = p0;

                  setState(() {});
                },
                function: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectLecture(
                      lectures: courses![i].sections[sectionindex].lectures,
                      header:
                          "${courses![i].id!} ,${courses![i].sections[sectionindex].id}",
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
