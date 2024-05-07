import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_reminders/controller/endpoin.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/styles/toast.dart';
import 'package:health_reminders/views/AppMenu/menu/food.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class addmenucalPage extends StatefulWidget {
  final String userId;

  const addmenucalPage({required this.userId});

  @override
  State<addmenucalPage> createState() => _addmenucalPageState();
}

class _addmenucalPageState extends State<addmenucalPage> {
  final ImagePicker _picker = ImagePicker();
  File? _file;
  String? selectedFoodLabel;

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController callorieController = TextEditingController();
  final TextEditingController sodiumController = TextEditingController();
  final TextEditingController sweetController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  final List<String> foodItems = [
    'ของคาว',
    'ของหวาน',
    'เครื่องดื่ม',
    'ผลไม้',
    'ผัก',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'อาหาร',
          style: TextStyle(
            color: Colors.brown,
            fontFamily: 'Garuda',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
          }

          var userData = snapshot.data!.data();
          if (userData == null) {
            return Center(
              child: Text('ไม่พบข้อมูลผู้ใช้'),
            );
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .collection('health_data')
                .doc(widget.userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
              }

              Map<String, dynamic>? healthData =
                  snapshot.data!.data() as Map<String, dynamic>?;

              if (healthData == null) {
                return Center(
                  child: Text('ไม่พบข้อมูลสุขภาพ'),
                );
              }

              double userBMR = calBMR(
                healthData['weight'],
                healthData['height'],
                healthData['gender'],
                healthData['age'],
              );

              double TDEE = bmrExercise(userBMR, healthData['exerciseLevel']);

              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: yellow,
                            ),
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 12.0),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'ชื่ออาหาร',
                              labelStyle: TextStyle(
                                  color: brown, // สีของ labelText
                                  fontSize: 16,
                                  fontFamily:
                                      'Garuda' // ขนาด font ของ labelText
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 12.0),
                          child: TextField(
                            controller: callorieController,
                            decoration: InputDecoration(
                              labelText: 'จำนวนแคลอรี่',
                              labelStyle: TextStyle(
                                  color: brown, // สีของ labelText
                                  fontSize: 16,
                                  fontFamily:
                                      'Garuda' // ขนาด font ของ labelText
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 12.0),
                          child: TextField(
                            controller: sweetController,
                            decoration: InputDecoration(
                              labelText: 'ปริมาณน้ำตาล',
                              labelStyle: TextStyle(
                                  color: brown, // สีของ labelText
                                  fontSize: 16,
                                  fontFamily:
                                      'Garuda' // ขนาด font ของ labelText
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 12.0),
                          child: TextField(
                            controller: sodiumController,
                            decoration: InputDecoration(
                              labelText: 'ปริมาณโซเดียม',
                              labelStyle: TextStyle(
                                  color: brown, // สีของ labelText
                                  fontSize: 16,
                                  fontFamily:
                                      'Garuda' // ขนาด font ของ labelText
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 12.0),
                          child: TextField(
                            controller: fatController,
                            decoration: InputDecoration(
                              labelText: 'ปริมาณไขมัน',
                              labelStyle: TextStyle(
                                  color: brown, // สีของ labelText
                                  fontSize: 16,
                                  fontFamily:
                                      'Garuda' // ขนาด font ของ labelText
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
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
                                  vertical: 0.0, horizontal: 60.0),
                              child: DropdownButton<String>(
                                hint: Text(
                                  "เลือกประเภทอาหาร",
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 16,
                                    fontFamily: 'Garuda',
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.brown,
                                ),
                                iconSize: 36,
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 16,
                                  fontFamily: 'Garuda',
                                ),
                                value: selectedFoodLabel,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedFoodLabel = newValue;
                                  });
                                },
                                items: foodItems.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.brown,
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
                        ElevatedButton(
                          style: buttonlgin,
                          onPressed: () async {
                            String? filePath =
                                _file?.path; // แปลงเป็นชื่อไฟล์เต็ม
                            if (filePath != null) {
                              // สร้างชื่อไฟล์ใหม่ในรูปแบบ foods/1711975971394.png
                              String imageUrl =
                                  await APIEndpoint.uploadImageToFirebase(
                                      _file);

                              UserOperator.addFoodUser(
                                  context,
                                  widget.userId,
                                  imageUrl, // ส่งชื่อไฟล์เต็มไปยังฟังก์ชัน
                                  nameController.text.trim(),
                                  double.parse(callorieController.text.trim()),
                                  double.parse(fatController.text.trim()),
                                  double.parse(sweetController.text.trim()),
                                  double.parse(sodiumController.text.trim()),
                                  TDEE,
                                  selectedFoodLabel!);
                            }

                            ToastStyles.showToastFoodAddToCal(context);
                          },
                          child: Text('ยืนยัน', style: TextStyles.Tlogin),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: foodPage(
                                      userId: widget.userId,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'เพิ่มเมนูจากหน้าอาหาร',
                                textAlign: TextAlign.end,
                                style: TextStyles.Tunder,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
