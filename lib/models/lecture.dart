import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior_project/models/attendance.dart';

class Lecture {
  final String? id;
  DateTime? day;

  List<Attendance>? attendanceList;

  Lecture({
    this.id,
    this.day,
    this.attendanceList,
  });

  set setStudents(List<Attendance> students) => attendanceList = students;

  Lecture getLecture(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data()!;
    var lecture = Lecture(
      id: doc.id,
      day: data['time'],
    );

    return lecture;
  }
}
