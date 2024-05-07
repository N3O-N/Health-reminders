import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class IntervalRunsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: "การวิ่งเบาสลับหนัก",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'asset/image/intervalrun.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'การวิ่งเบาสลับหนักเป็นการใช้พลังงานแทบทั้งหมดจากคาร์บหลังจากวิ่งเสร็จจะทำให้ร่างกายเกิด Afterburn เผาผลาญไขมันได้มากกว่าปกติ 12-24 ชม ใช้ลดน้ำหนักควบคู่กับการออกแบบ Low zone เหมาะกับคนที่สุขภาพแข็งแรง ไม่มีโรคซ่อน โดยเฉพาะโรคหัวใจ',
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
                          child: Text('อัตราการเผาพลาญ 600-900 กิโลแคลอรี่ต่อชั่วโมง',
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
    );
  }
}
