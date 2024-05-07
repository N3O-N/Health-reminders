import 'package:flutter/material.dart';

import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/Admin/exercise_admin.dart';
import 'package:health_reminders/Admin/food_admin.dart';
import 'package:health_reminders/Admin/news_admin.dart';

class adminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ADMIN",
          style: TextStyle(
            color: Colors.brown, // Assuming 'brown' is a defined color variable
            fontFamily: 'Garuda',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: buttonnoti,
                            onPressed: () {
                              print('go to foodadmin');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => food_adminPage()),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Icon(Icons.female, color: brown,),
                                Text(
                                  'อาหาร',
                                  style: TextStyles.login,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: buttonnoti,
                            onPressed: () {
                              // Handle the first button press
                              print('go to exerciseadmin ');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => exercise_adminPage()),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Icon(Icons.female, color: brown,),
                                Text(
                                  'ออกกำลังกาย',
                                  style: TextStyles.login,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: buttonnoti,
                            onPressed: () {
                              // Handle the first button press
                              print('go to newsadmin');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => news_adminPage()),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Icon(Icons.female, color: brown,),
                                Text(
                                  'ข่าวสารสุขภาพ',
                                  style: TextStyles.login,
                                ),
                              ],
                            )),
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
