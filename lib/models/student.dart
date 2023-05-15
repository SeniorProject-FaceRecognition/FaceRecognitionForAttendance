import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? id;
  String? studentId;
  String? name;

  Student({
    this.id,
    this.studentId,
    this.name,
  });

  Student getStudent(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data()!;
    var student = Student(
      id: doc.id,
      studentId: data['id'],
      name: data['name'],
    );

    return student;
  }
}
