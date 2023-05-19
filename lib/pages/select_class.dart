import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/Widgets/course_widget.dart';
import 'package:senior_project/models/instructor.dart';
import 'package:senior_project/models/section.dart';
import 'package:senior_project/pages/select_Lecture.dart';

import '../services/authentication.dart';

class SelectClass extends StatefulWidget {
  const SelectClass({
    super.key,
    required this.instructorId,
  });
  final String instructorId;
  @override
  State<SelectClass> createState() => _SelectClassState();
}

List<Section>? sections = [];
Instructor? instructor;

class _SelectClassState extends State<SelectClass> {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  int sectionindex = 0;
  bool isLoading = true;

  @override
  void initState() {
    loadInstructor();
    loadSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);

    if (isLoading) {
      return const CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
      );
    } else {
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
          title: Text("Welcome, Dr. ${instructor!.name!}"),
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
                      instructorId: widget.instructorId,
                      header: sections![sectionindex].name,
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

  void loadInstructor() async {
    var doc =
        await database.collection('instructor').doc(widget.instructorId).get();
    if (doc.exists) {
      instructor = Instructor.getInstructor(doc);

      setState(() {
        isLoading = false;
      });
    }
  }

  void loadSections() async {
    var collection = await database
        .collection('instructor')
        .doc(widget.instructorId)
        .collection('sections')
        .get();

    sections = collection.docs.map((e) => Section.getSection(e)).toList();
  }
}
