import 'package:senior_project/models/student.dart';

class Attendance {
  Student? student;
  bool? isPresent = false;

  Attendance(this.student);
  set setIsPresent(bool x) => isPresent = x;
}
