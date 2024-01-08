import 'package:flutter/material.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class addmenucalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController callorieController = TextEditingController();
    final TextEditingController qtyController = TextEditingController();
    final TextEditingController sodiumController = TextEditingController();
    final TextEditingController sweetController = TextEditingController();
    final TextEditingController fatController = TextEditingController();

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text( 'อาหาร', 
            style: TextStyle(
            color: Colors.brown, // Assuming 'brown' is a defined color variable
            fontFamily: 'Garuda',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
         actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'เพิ่ม',
            style: TextStyle(
              color: Colors.brown, // Assuming 'brown' is a defined color variable
              fontFamily: 'Garuda',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
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
                      'กรุณากรอกข้อมูล',textAlign: TextAlign.end,
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
                      controller: qtyController,
                      decoration: InputDecoration(
                        labelText: 'จำนวนต่อหน่วย',
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
                      controller: sweetController,
                      decoration: InputDecoration(
                        labelText: 'ปริมาณน้ำตาล',
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
                      controller: sodiumController,
                      decoration: InputDecoration(
                        labelText: 'ปริมาณโซเดียม',
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
                      controller: fatController,
                      decoration: InputDecoration(
                        labelText: 'ปริมาณไขมัน',
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
                height: 20,
                ),

                Column(
                
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                    child: Text(
                      'เพิ่มเมนูจากหน้าอาหาร',textAlign: TextAlign.end, style: TextStyles.Tunder
                    ),
                    ),
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
