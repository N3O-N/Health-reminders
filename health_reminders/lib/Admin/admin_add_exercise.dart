import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:image_picker/image_picker.dart';

class admin_add_exercisePage extends StatefulWidget {
   @override
  State<admin_add_exercisePage> createState() => _admin_add_exercisePageState();
}
class _admin_add_exercisePageState extends State<admin_add_exercisePage> {
  final ImagePicker _picker = ImagePicker();

  File? _file;

  FutureOr<void> pickImage() async {
    final PickedFile? pickedFile =
        (await _picker.pickImage(source: ImageSource.gallery)) as PickedFile?;
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    int? activityLevel;

  List<String> listitem = [
    "การวิ่ง",
    "คาดิโอ",
    "โยคะ",
    "แอโรบิค",
  ];

    final TextEditingController nameController = TextEditingController();
    final TextEditingController informationController = TextEditingController();
    final TextEditingController linkController = TextEditingController();
   

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'เพิ่มการออกกำลังกาย',
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
                          onTap: pickImage,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: aa),
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
                          labelText: 'ชื่อท่าออกกำลังกาย',
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
                            controller: informationController,
                            decoration: InputDecoration(
                              labelText: 'คำอธิบาย',
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
                                controller: linkController,
                                decoration: InputDecoration(
                                  labelText: 'link',
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
                             Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 12.0),
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
                        child: DropdownButton(
                          hint: Text(
                            "หมวดหมู่",
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
                          iconSize: 30,
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
                            
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: buttonlgin,
                                  onPressed: () {
                                    // Handle the first button press
                                    print('Button 1 Pressed');
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
              
            ),
          ),
        ),
      
    );
  }
}
