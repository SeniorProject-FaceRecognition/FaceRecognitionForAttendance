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
  Student(studentId: "1937439", name: "Mohammed"),
  Student(studentId: "2056841", name: "Khalid"),
  Student(studentId: "1865454", name: "Abdullah"),
];
List<Section>? sections = [
  Section(
    name: "IT1",
    days: "TRU",
    time: "13:00 - 14:40",
    lectures: [],
    courseId: "CPIT - 201",
    students: students,
  ),
  Section(
    name: "IT2",
    days: "TRU",
    time: "11:00 - 12:40",
    lectures: [],
    courseId: "CPIT - 401",
    students: [],
  ),
  Section(
    name: "IT3",
    days: "TRU",
    time: "15:00 - 16:40",
    lectures: [],
    courseId: "CPIT - 425",
    students: [],
  ),
];

//  void loadUser() async {
//     var doc = await userController.database
//         .collection('users')
//         .doc(auth.user!.uid)
//         .get();
//     if (doc.exists) {
//       appUser = auth.getAppUser(doc);
//       setState(() {
//         isLoading = false;
//       });
//     } else {
//       auth.deleteUser();
//     }
//   }

class _SelectClassState extends State<SelectClass> {
  Instructor? lecturer = Instructor(
    name: 'Motasem Aljarah',
    id: 'id',
    image: 'image',
    sections: [],
  );

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
