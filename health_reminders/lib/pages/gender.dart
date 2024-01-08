import 'package:flutter/material.dart';
import 'package:health_reminders/pages/information.dart';
import 'package:health_reminders/pages/login.dart';
import 'package:health_reminders/pages/register.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class genderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              // Handle the "ข้าม" action
              print('skip');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้าม',
                style: TextStyle(
                  color: const Color.fromARGB(255, 43, 48, 53),
                  decoration: TextDecoration.underline,
                  fontFamily: 'Garuda',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      
      body: Center(
        
        child: Container(
          child: Column(
            children: <Widget>[
              
              SizedBox(
                height: 190,
              ),
              Column(
                children: [
                  Text(
                    'เพศ',
                    style: TextStyle(
                        color: Color.fromRGBO(107, 89, 24, 1),
                        fontFamily: 'Garuda',
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      style: buttonwomen,
                      onPressed: () {
                        // Handle the first button press
                        print('Button 1 Pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => informationPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                                  Icon(Icons.female, color: brown,),
                                  Text('ผู้หญิง',
                                    style: TextStyles.login,
                                  ),
                      ],
                      ) 
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 10),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      
                      style: buttonman,
                      onPressed: () {
                        // Handle the second button press
                        print('Button 2 Pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => informationPage()),
                        );
                      },
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // จัดตำแหน่ง
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.male,color: brown,),
                          //SizedBox(width: 8),
                          
                          Text(
                            'ผู้ชาย',
                            style: TextStyles.login,
                          ),
                      ],
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

