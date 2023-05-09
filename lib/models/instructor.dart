import 'package:senior_project/models/section.dart';

class Instructor {
  final String? name;
  final String? id;
  final String? image;
  final List<Section>? sections;
  Instructor(this.name, this.id, this.image, this.sections);
}
