import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class admin_add_foodPage extends StatefulWidget {
  @override
  State<admin_add_foodPage> createState() => _admin_add_foodPageState();
}

class _admin_add_foodPageState extends State<admin_add_foodPage> {
  Uint8List? _fileBytes;
  String? _downloadUrl;
  String? selectedFoodLabel;

  Future<void> _pickImage() async {
    html.FileUploadInputElement input = html.FileUploadInputElement();
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) async {
        setState(() {
          _fileBytes = reader.result as Uint8List?;
        });
      });

      reader.readAsArrayBuffer(file);
    });
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
        automaticallyImplyLeading: false,
        title: Text(
          'เพิ่มเมนูอาหาร',
          style: TextStyle(
            color: Colors.brown, // Assuming 'brown' is a defined color variable
            fontFamily: 'Garuda',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: aa),
                            child: _fileBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.memory(
                                      _fileBytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.photo_outlined,
                                    size: 60,
                                    color: Colors
                                        .brown, // แก้ brown เป็นสีที่ต้องการ
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
                          style: TextStyles.common2,
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
                          labelText: 'ชื่ออาหาร',
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
                    Column(
                      children: [
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
                        Column(
                          children: [
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
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
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
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
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
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 30.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
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
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: buttonlgin,
                                  onPressed: () {
                                    UserOperator.addFood(
                                        context,
                                        _fileBytes,
                                        nameController.text.trim(),
                                        double.parse(
                                          callorieController.text.trim(),
                                        ),
                                        double.parse(
                                          fatController.text.trim(),
                                        ),
                                        double.parse(
                                          sweetController.text.trim(),
                                        ),
                                        double.parse(
                                          sodiumController.text.trim(),
                                        ),
                                        selectedFoodLabel!);
                                  },
                                  child: Text('เพิ่มข้อมูล',
                                      style: TextStyles.Tlogin),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
