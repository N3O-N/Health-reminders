import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:image_picker/image_picker.dart';

class informationScreen extends StatefulWidget {
  final String userId;
  final String gender;
  final String email;
  final String password;

  informationScreen(
      {required this.userId,
      required this.gender,
      required this.email,
      required this.password});

  @override
  _informationScreenState createState() => _informationScreenState();
}

class _informationScreenState extends State<informationScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _file;
  int? activityLevel;

  List<String> listitem = [
    "ไม่มีการออกกำลังกาย",
    "ออกกำลังกายเล็กน้อยอาทิตย์ละ 1-3 วัน",
    "ออกกำลังกายปานกลางอาทิตย์ละ 3-5 วัน",
    "ออกกำลังกายอย่างหนักอาทิตย์ละ 6-7 วัน",
    "ออกกำลังกายอย่างหนักทุกวัน"
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ข้อมูล"),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: yellow),
                          child: _file != null
                              ? ClipOval(
                                  child: Image.file(
                                    _file!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.photo_outlined,
                                  size: 60,
                                  color: brown,
                                ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'กรุณากรอกข้อมูลทั้งหมด',
                      textAlign: TextAlign.end,
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
                        labelText: 'ชื่อ',
                        labelStyle: TextStyle(
                            color: brown, fontSize: 16, fontFamily: 'Garuda'),
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
                  SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 12.0),
                    child: TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'อายุ',
                        labelStyle: TextStyle(
                            color: brown, fontSize: 16, fontFamily: 'Garuda'),
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
                  SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5.0, left: 30, top: 12.0, bottom: 12.0),
                          child: TextField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'น้ำหนัก (กก.)',
                              labelStyle: TextStyle(
                                color: Colors.brown,
                                fontSize: 16,
                                fontFamily: 'Garuda',
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
                      ),
                      SizedBox(width: 1),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 30.0, left: 5, top: 12.0, bottom: 12.0),
                          child: TextField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'ส่วนสูง (ซม.)',
                              labelStyle: TextStyle(
                                color: Colors.brown,
                                fontSize: 16,
                                fontFamily: 'Garuda',
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
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 30.0, left: 30.0, top: 12.0, bottom: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8.0),
                        child: DropdownButton(
                          hint: Text(
                            "ระดับการออกกำลังกาย",
                            style: TextStyle(
                              color: brown,
                              fontSize: 16,
                              fontFamily: 'Garuda',
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: brown,
                          ),
                          iconSize: 36,
                          style: TextStyle(
                            color: brown,
                            fontSize: 16,
                            fontFamily: 'Garuda',
                          ),
                          value: activityLevel != null
                              ? listitem[activityLevel!]
                              : null,
                          onChanged: (newValue) {
                            setState(() {
                              activityLevel = listitem.indexOf(newValue!);
                            });
                          },
                          items: listitem.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: brown,
                                  fontSize: 16,
                                  fontFamily: 'Garuda',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1),
              ElevatedButton(
                style: buttonlgin,
                onPressed: () {
                  // Handle the button press to save data
                  if (activityLevel != null &&
                      nameController.text.trim().isNotEmpty &&
                      ageController.text.trim().isNotEmpty &&
                      weightController.text.trim().isNotEmpty &&
                      heightController.text.trim().isNotEmpty) {
                    UserOperator.addInfo(
                      context,
                      widget.userId,
                      widget.email,
                      widget.password,
                      _file,
                      nameController.text.trim(),
                      widget.gender,
                      int.parse(ageController.text.trim()),
                      double.parse(weightController.text.trim()),
                      double.parse(heightController.text.trim()),
                      activityLevel!,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('แจ้งเตือน'),
                          content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ตกลง'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('ยืนยัน', style: TextStyles.Tlogin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
