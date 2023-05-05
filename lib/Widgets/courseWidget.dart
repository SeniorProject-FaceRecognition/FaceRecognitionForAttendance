import 'package:flutter/material.dart';
import 'package:senior_project/models/Section.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget({super.key, required this.sections});

  final List<Section> sections;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(sections[index].courseName!),
                Padding(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  child: Text(sections[index].id!),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
