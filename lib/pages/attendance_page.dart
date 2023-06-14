import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/models/lecture.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/attendance.dart';
import '../models/section.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage(
      {super.key, this.lecture, this.time, this.section, this.instructor});
  final Lecture? lecture;
  final DateTime? time;
  final Section? section;
  final String? instructor;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

List<Attendance> studentsAttendance = [];

class _AttendancePageState extends State<AttendancePage> {
  final FirebaseFirestore database = FirebaseFirestore.instance;
  Set<String> presentStudentIds = {};
  bool isLoading = true;
  String url = "10.24.30.157";
  @override
  void initState() {
    loadAttendance();
    //print(widget.lecture!.day);
    super.initState();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('http://$url:5000/api'));
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final studentIds = List<String>.from(jsonData["names"]);
        presentStudentIds = Set<String>.from(studentIds);
        print(studentIds);
        print(presentStudentIds);
      } else {
        // Handle the error condition
      }
    } catch (e) {
      // Handle any exception that occurs during the request
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
      );
    } else {
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
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: fetchData,
            ),
          ],
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
                      onTap: () {
                        updateAttendance(studentsAttendance[index]);
                        setState(() {});
                      },
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
  }

  void loadAttendance() async {
    var path = await database
        .collection('instructor')
        .doc(widget.instructor!)
        .collection('sections')
        .doc(widget.section!.id)
        .collection('lectures')
        .doc(widget.lecture!.id!)
        .collection('attendance');
    var checkIfEmpty = await path.limit(1).get();

    var collection = await path.get();

    if (checkIfEmpty.size != 1) {
      genarateAttendance();
      studentsAttendance =
          collection.docs.map((e) => Attendance.getAttendance(e)).toList();
      isLoading = false;
      setState(() {});
    } else {
      studentsAttendance =
          collection.docs.map((e) => Attendance.getAttendance(e)).toList();
      isLoading = false;
      setState(() {});
    }
  }

  void genarateAttendance() async {
    for (var i = 0; i < widget.section!.students!.length; i++) {
      var student = widget.section!.students![i];
      await database
          .collection('instructor')
          .doc(widget.instructor!)
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

  void updateAttendance(Attendance attendance) async {
    var doc = database
        .collection('instructor')
        .doc(widget.instructor!)
        .collection('sections')
        .doc(widget.section!.id)
        .collection('lectures')
        .doc(widget.lecture!.id!)
        .collection('attendance')
        .doc(attendance.id);

    await doc.set(
      {'isPresent': !attendance.isPresent!},
      SetOptions(merge: true),
    );

    attendance.isPresent = !attendance.isPresent!;
    setState(() {});
  }
}
