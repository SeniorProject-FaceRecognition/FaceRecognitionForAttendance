import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior_project/models/section.dart';

class Instructor {
  final String? id;
  String? name;
  String? image;
  List<Section>? sections;

  Instructor({this.name, this.id, this.image, this.sections});

  Instructor getInstructor(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data()!;
    var instructor = Instructor(
      id: doc.id,
      name: data['name'],
      image: data['image'],
    );

    return instructor;
  }
}
