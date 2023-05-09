import 'package:flutter/material.dart';
import 'package:senior_project/models/section.dart';

// ignore: must_be_immutable
class CourseWidget extends StatefulWidget {
  CourseWidget({super.key, this.function, this.onSelectParam, this.sections});
  final List<Section>? sections;
  final VoidCallback? function;
  Function(int)? onSelectParam;
  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.sections!.length,
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
              child: Text(
                "${widget.sections![index].id!} ${widget.sections![index].courseId!}",
              ),
            ),
          ),
        );
      },
    );
  }
}
