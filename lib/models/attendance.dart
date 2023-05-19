import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String? id;
  String? studentId;
  String? name;
  bool? isPresent = false;

  Attendance({this.id, this.studentId, this.name, this.isPresent});

  factory Attendance.getAttendance(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data()!;
    var attendance = Attendance(
      id: doc.id,
      studentId: data['studentId'],
      name: data['name'],
      isPresent: data['isPresent'],
    );

    return attendance;
  }
}
