import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class warriorposePage extends StatefulWidget {
  @override
  State<warriorposePage> createState() => _warriorposePageState();
}

class _warriorposePageState extends State<warriorposePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ท่านักรบ"),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'asset/image/yoga-2.jpg',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(
              width: 50.0,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'โยคะ ท่านักรบ สามารถทำต่อจากท่า Downward Facing Dog ได้เลย โดยหายใจเข้า ก้าวเท้าขวาไปด้านหน้า วางเท้าขวาระหว่างมือ โดยงอเข่าด้านขวา และขาซ้ายเหยียดตรง จากนั้น ถ่ายน้ำหนักไปที่เท้าทั้งสองข้างให้เท่ากันจากนั้นยกตัวขึ้น โดยงอเข่าขวาเป็นมุมฉาก และยกแขนทั้งสองข้างขึ้น ค้างในท่านี้ ไว้ประมาณ 30-60 วินาที แล้วกลับไปสู่ท่า Downward Facing Dog แล้วจึงค่อยสลับทำอีกข้าง',
                    style: TextStyles.common2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ]),
                 SizedBox(
              height: 15,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
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
                    padding: const EdgeInsets.only(left: 11, top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          child: Text('เน้นการยืดกล้ามเนื้อ',
                              style: TextStyles.common3),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('อัตราการเผาพลาญ 2-4 กิโลแคลอรี่ต่อนาที',
                              style: TextStyles.common2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
