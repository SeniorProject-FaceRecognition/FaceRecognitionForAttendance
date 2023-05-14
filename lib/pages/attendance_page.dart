import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/models/lecture.dart';

import '../models/section.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key, this.lecture, this.time, this.section});
  final Lecture? lecture;
  final DateTime? time;
  final Section? section;
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.section!.courseId!} ${widget.section!.id!}"),
            Row(
              children: [
                Text(
                  DateFormat.MMMMEEEEd().format(widget.time!),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.jm().format(widget.lecture!.day!),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
          itemCount: widget.lecture!.attendanceList!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.lecture!.attendanceList![index].id!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    widget.lecture!.attendanceList![index].name!,
                  ),
                  InkWell(
                    onTap: () => setState(
                      () {
                        widget.lecture!.attendanceList![index].setIsPresent =
                            !widget.lecture!.attendanceList![index].isPresent!;
                      },
                    ),
                    child: Text(
                      style: TextStyle(
                          color:
                              widget.lecture!.attendanceList![index].isPresent!
                                  ? Colors.green
                                  : Colors.red,
                          fontWeight: FontWeight.w600),
                      widget.lecture!.attendanceList![index].isPresent!
                          ? "Present"
                          : "Absent",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
