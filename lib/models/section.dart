import 'package:senior_project/models/lecture.dart';

class Section {
  final String? id;
  final String? days;
  final String? time;
  final List<Lecture>? lectures;

  Section(this.id, this.days, this.time, this.lectures);
}
