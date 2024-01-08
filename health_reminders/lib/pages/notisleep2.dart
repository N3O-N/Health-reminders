import 'package:flutter/material.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class  notisleep2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text( 'เวลานอน', 
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
                            top: 12.0,
                            bottom: 12.0,
                            
                          ),
                          child: TextField(
                            controller: dateController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'วันเดือนปี',
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
                            right: 30.0,
                            left: 5,
                            top: 12.0,
                            bottom: 12.0,
                            
                          ),
                          child: TextField(
                            controller: timeController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'เวลา',
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

                    
                Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 12.0),
                    child: TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        labelText: 'บันทึกเพิ่มเติม',
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
