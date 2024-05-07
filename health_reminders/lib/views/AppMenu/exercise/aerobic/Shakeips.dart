import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class ShakeipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: "ส่ายสะโพก",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            
            children: [
              SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'asset/image/arobic-15.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'การส่ายสะโพกซ้าย – ขวา สลับกัน',
                    style: TextStyles.common2,
                    softWrap: true,
                        overflow: TextOverflow.visible,
                  ),
                ],
              ),
              SizedBox(
              height: 15,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 330,
                  decoration: BoxDecoration(
                    //border: Border.all(color: brown, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                        color: aa,
                        // blurRadius:5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Align(
                          alignment: Alignment.center,
                          child: Text('อัตราการเผาพลาญ 150-200 กิโลแคลอรี่ต่อชั่วโมง',
                              style: TextStyles.common2),
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
