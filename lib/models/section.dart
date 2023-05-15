import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior_project/models/lecture.dart';
import 'package:senior_project/models/student.dart';

class Section {
  String? id;
  String? name;
  String? days;
  String? time;
  String? courseId;
  List<Lecture>? lectures;
  List<Student>? students;

  Section({
    this.id,
    this.name,
    this.days,
    this.time,
    this.lectures,
    this.courseId,
    this.students,
  });

  Section getSection(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data()!;
    var section = Section(
      id: doc.id,
      name: data['sectionId'],
      courseId: data['courseId'],
      days: data['days'],
      time: data['time'],
    );

    return section;
  }
}
