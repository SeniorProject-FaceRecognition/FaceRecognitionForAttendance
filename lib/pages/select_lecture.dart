import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/models/lecture.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectLecture extends StatefulWidget {
  const SelectLecture({super.key, this.lectures, this.header});

  final List<Lecture>? lectures;
  final String? header;

  @override
  State<SelectLecture> createState() => _SelectLectureState();
}

DateTime date = DateTime.now();

List<Lecture> lectures = [];

class _SelectLectureState extends State<SelectLecture> {
  @override
  void initState() {
    lectures = widget.lectures!
        .where((element) =>
            DateFormat.Md()
                .format(date)
                .compareTo(DateFormat.Md().format(element.day!)) ==
            0)
        .toList();
    lectures.sort(
      (a, b) => a.day!.compareTo(b.day!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      content: Container(
                        height: height / 2,
                        width: width / 2,
                        color: Colors.white,
                        child: SfDateRangePicker(
                          onSelectionChanged:
                              (dateRangePickerSelectionChangedArgs) {
                            date = dateRangePickerSelectionChangedArgs.value;
                            setState(() {});
                          },
                        ),
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
              itemCount: lectures.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(DateFormat.jm().format(lectures[index].day!)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
