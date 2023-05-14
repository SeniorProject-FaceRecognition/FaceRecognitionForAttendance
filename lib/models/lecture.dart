import 'package:senior_project/models/student.dart';

class Lecture {
  final DateTime? day;

  List<Student>? attendanceList;

  Lecture(
    this.day,
    this.attendanceList,
  );

  set setStudents(List<Student> students) => attendanceList = students;
}
