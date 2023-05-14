import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/models/lecture.dart';
import 'package:senior_project/models/section.dart';
import 'package:senior_project/models/student.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'attendance_page.dart';

class SelectLecture extends StatefulWidget {
  const SelectLecture({super.key, this.section, this.header});

  final Section? section;
  final String? header;

  @override
  State<SelectLecture> createState() => _SelectLectureState();
}

DateTime date = DateTime.now();

class _SelectLectureState extends State<SelectLecture> {
  List<Lecture> lectures = [
    Lecture(DateTime(2023, 5, 7, 13, 00), []),
    Lecture(DateTime(2023, 5, 7, 11, 00), []),
    Lecture(DateTime(2023, 5, 7, 15, 00), []),
    Lecture(DateTime(2023, 5, 10, 15, 00), []),
    Lecture(DateTime(2023, 5, 9, 15, 00), []),
    Lecture(DateTime(2023, 5, 8, 15, 00), []),
  ];

//TODO different students list objects to differeniate attendance status
  @override
  void initState() {
    for (var i = 0; i < lectures.length; i++) {
      List<Student>? students = widget.section!.students;
      lectures[i].setStudents = students!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.section!.lectures = lectures
        .where((element) =>
            DateFormat.Md()
                .format(date)
                .compareTo(DateFormat.Md().format(element.day!)) ==
            0)
        .toList();
    widget.section!.lectures!.sort(
      (a, b) => a.day!.compareTo(b.day!),
    );
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.header!),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Text(
                DateFormat.MMMMEEEEd().format(date),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Select a date :"),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    return AlertDialog(
                      content: Stack(
                        children: [
                          Container(
                            height: height / 1.5,
                            width: width,
                            color: Colors.white,
                            child: SfDateRangePicker(
                              onSelectionChanged:
                                  (dateRangePickerSelectionChangedArgs) {
                                date =
                                    dateRangePickerSelectionChangedArgs.value;
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Positioned(
                            bottom: 10,
                            child: RawMaterialButton(
                              fillColor: const Color(0xFF0069FE),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Ok',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                child: const Icon(
                  Icons.calendar_month,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 36,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.section!.lectures!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(
                        lecture: widget.section!.lectures![index],
                        time: date,
                        section: widget.section,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      DateFormat.jm().format(
                        widget.section!.lectures![index].day!,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
