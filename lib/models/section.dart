import 'package:senior_project/models/lecture.dart';
import 'package:senior_project/models/student.dart';

class Section {
  final String? id;
  final String? days;
  final String? time;
  final String? courseId;
  List<Lecture>? lectures;
  List<Student>? students;

  Section(
    this.id,
    this.days,
    this.time,
    this.lectures,
    this.courseId,
    this.students,
  );
}
