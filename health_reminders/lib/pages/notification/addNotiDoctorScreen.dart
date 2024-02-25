import 'package:flutter/material.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/CustomAppBar.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:intl/intl.dart';

class addNotiDoctorScreen extends StatefulWidget {
  @override
  State<addNotiDoctorScreen> createState() => _addNotiDoctorScreenState();
}

class _addNotiDoctorScreenState extends State<addNotiDoctorScreen> {
  final TextEditingController nameController = TextEditingController();
    DateTime? selectedDate;
   TimeOfDay? selectedTime;
    final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //เลือกวัน
    Future<void> _selectedDate(BuildContext context) async {
      DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5),
      );

      if (pickDate != null && pickDate != selectedDate) {
        setState(
          () {
            selectedDate = pickDate;
          },
        );
      }
    }

    Future<void> _selectedTime(BuildContext context) async {
      TimeOfDay? pickTime = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
      );

      if (pickTime != null && pickTime != selectedTime) {
        setState(
          () {
            selectedTime = pickTime;
          },
        );
      }
    }

    String getTextTime() {
      return selectedTime == null
          ? 'เลือกเวลา'
          : '${selectedTime?.format(context)}';
    }

    String getTextDate() {
      return selectedDate == null
          ? 'เลือกวัน'
          : '${DateFormat('dd/MM/yyyy').format(selectedDate!)}';
    }
   
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
     appBar: CustomAppBarTextActions(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: "เวลานัดพบแพทย์",
        onActionButtonPressed: () {
          print(
              '${nameController.text.trim()}\n${noteController.text.trim()}\n$selectedDate\n$selectedTime');
        },
        textAction: 'เพิ่ม',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'กรุณากรอกข้อมูล',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'หมายนัด',
                          labelStyle: TextStyle(
                              color: brown, // สีของ labelText
                              fontSize: 16,
                              fontFamily: 'Garuda' // ขนาด font ของ labelText
                              ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Adjust the alignment as needed
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 5.0,
                              left: 30,
                            ),
                            child: DateButtom(
                                title: 'Date',
                                text: getTextDate(),
                                onClicked: (() => _selectedDate(context))),
                          ),
                        ),
                        SizedBox(width: 1),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 30.0,
                              left: 5,
                            ),
                            child: DateButtom(
                                title: 'Time',
                                text: getTextTime(),
                                onClicked: (() => _selectedTime(context))),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: noteController,
                        maxLines: null, // ให้ TextField มีหลายบรรทัด
                        textAlignVertical:
                            TextAlignVertical.top, // จัดการให้ข้อความชิดด้านบน
                        decoration: InputDecoration(
                          labelText: 'บันทึกเพิ่มเติม',
                          //hintText: 'กรอกบันทึกเพิ่มเติม',

                          labelStyle: TextStyle(
                            color: brown, // สีของ labelText
                            fontSize: 16,
                            fontFamily: 'Garuda', // ขนาด font ของ labelText
                          ),

                          contentPadding:
                              EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 70.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
