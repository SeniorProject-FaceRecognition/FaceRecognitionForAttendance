import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/models/instructor.dart';
import 'package:senior_project/models/lecture.dart';

import '../models/attendance.dart';
import '../models/section.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage(
      {super.key, this.lecture, this.time, this.section, this.instructor});
  final Lecture? lecture;
  final DateTime? time;
  final Section? section;
  final Instructor? instructor;
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Attendance> studentsAttendance = [];
  final FirebaseFirestore database = FirebaseFirestore.instance;
  @override
  void initState() {
    loadAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.section!.courseId!} ${widget.section!.name!}"),
            Row(
              children: [
                Text(
                  DateFormat.MMMMEEEEd().format(widget.time!),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.jm().format(widget.lecture!.day!),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
          itemCount: widget.section!.students!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    studentsAttendance[index].id!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    studentsAttendance[index].name!,
                  ),
                  InkWell(
                    onTap: () => setState(
                      () {},
                    ),
                    child: Text(
                      style: TextStyle(
                          color: studentsAttendance[index].isPresent!
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.w600),
                      studentsAttendance[index].isPresent!
                          ? "Present"
                          : "Absent",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void loadAttendance() async {
    var collection = await database
        .collection('instructor')
        .doc(widget.instructor!.id)
        .collection('sections')
        .doc(widget.section!.id)
        .collection('lectures')
        .doc(widget.lecture!.id!)
        .collection('attendance')
        .limit(widget.section!.students!.length)
        .get();

    if (collection.size != widget.section!.students!.length) {
      genarateAttendance();
    } else {
      studentsAttendance =
          collection.docs.map((e) => Attendance.getAttendance(e)).toList();
    }
  }

  void genarateAttendance() async {
    for (var i = 0; i < widget.section!.students!.length; i++) {
      var student = widget.section!.students![i];
      await database
          .collection('instructor')
          .doc(widget.instructor!.id)
          .collection('sections')
          .doc(widget.section!.id)
          .collection('lectures')
          .doc(widget.lecture!.id!)
          .collection('attendance')
          .doc(student.id)
          .set(
        {'studentId': student.id, 'name': student.name, 'isPresent': false},
      );
    }
  }
}
