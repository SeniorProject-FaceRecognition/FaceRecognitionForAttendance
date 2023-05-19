import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  final String? id;
  DateTime? day;

  Lecture({
    this.id,
    this.day,
  });

  factory Lecture.getLecture(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data()!;
    var lecture = Lecture(
      id: doc.id,
      day: (data['time'] as Timestamp).toDate(),
    );

    return lecture;
  }
}
