import 'package:flutter/material.dart';
import 'package:senior_project/models/course.dart';

// ignore: must_be_immutable
class CourseWidget extends StatefulWidget {
  CourseWidget(
      {super.key, required this.course, this.function, this.onSelectParam});

  final Course? course;
  final VoidCallback? function;
  Function(int)? onSelectParam;
  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
          child: Text(widget.course!.id!),
        ),
        const SizedBox(
          height: 4,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.course!.sections.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.function!.call();
                  widget.onSelectParam!(index);
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(widget.course!.sections[index].id!),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
