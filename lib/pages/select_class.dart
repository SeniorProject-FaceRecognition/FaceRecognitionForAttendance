import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/Widgets/course_widget.dart';
import 'package:senior_project/models/instructor.dart';
import 'package:senior_project/models/section.dart';
import 'package:senior_project/pages/select_Lecture.dart';

import '../models/student.dart';
import '../services/authentication.dart';

class SelectClass extends StatefulWidget {
  const SelectClass({
    super.key,
  });

  @override
  State<SelectClass> createState() => _SelectClassState();
}

List<Student>? students = [
  Student("1937439", "Mohammed"),
  Student("2056841", "Khalid"),
  Student("1865454", "Abdullah"),
];
List<Section>? sections = [
  Section("IT1", "TRU", "13:00 - 14:40", [], "CPIT - 201", students),
  Section("IT2", "TRU", "11:00 - 12:40", [], "CPIT - 401", []),
  Section("IT3", "TRU", "15:00 - 16:40", [], "CPIT - 425", []),
];

class _SelectClassState extends State<SelectClass> {
  Instructor? lecturer = Instructor('Motasem Aljarah', 'id', 'image', []);

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
            child: Text("Courses:"),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: CourseWidget(
              sections: sections,
              onSelectParam: (p0) {
                sectionindex = p0;

                setState(() {});
              },
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectLecture(
                    header: sections![sectionindex].id,
                    section: sections![sectionindex],
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
