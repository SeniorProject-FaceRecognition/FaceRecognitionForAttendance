import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/models/lecture.dart';
import 'package:senior_project/models/section.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../models/student.dart';
import 'attendance_page.dart';

class SelectLecture extends StatefulWidget {
  const SelectLecture(
      {super.key, this.section, this.header, this.instructorId});
  final String? instructorId;
  final Section? section;
  final String? header;

  @override
  State<SelectLecture> createState() => _SelectLectureState();
}

class _SelectLectureState extends State<SelectLecture> {
  final FirebaseFirestore database = FirebaseFirestore.instance;
  var date = DateTime.now();
  List<Student>? students = [];
  List<Lecture> lectures = [];
  List<Lecture> selectedDateLectures = [];
  @override
  void initState() {
    loadLectures();
    loadStudents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedDateLectures = lectures
        .where((element) =>
            DateFormat.Md()
                .format(date)
                .compareTo(DateFormat.Md().format(element.day!)) ==
            0)
        .toList();
    selectedDateLectures.sort(
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
              itemCount: selectedDateLectures.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(
                        instructor: widget.instructorId,
                        lecture: selectedDateLectures[index],
                        time: selectedDateLectures[index].day,
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
                        selectedDateLectures[index].day!,
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

  void loadStudents() async {
    var collection = await database
        .collection('instructor')
        .doc(widget.instructorId!)
        .collection('sections')
        .doc(widget.section!.id)
        .collection('students')
        .get();

    students = collection.docs.map((e) => Student.getStudent(e)).toList();
    widget.section!.students = students;
  }

  void loadLectures() async {
    var collection = await database
        .collection('instructor')
        .doc(widget.instructorId!)
        .collection('sections')
        .doc(widget.section!.id)
        .collection('lectures')
        .get();

    lectures = collection.docs.map((e) => Lecture.getLecture(e)).toList();
  }
}
