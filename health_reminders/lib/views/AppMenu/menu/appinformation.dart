import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class appinformationPage extends StatefulWidget {
  @override
  State<appinformationPage> createState() => _appinformationPageState();
}

class _appinformationPageState extends State<appinformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ข้อมูลเกี่ยวกับแอปพลิเคชัน"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Padding(
            padding: const EdgeInsets.only(left: 11, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'สูตรคำนวณปริมาณน้ำที่ควรได้รับ',
                  style: TextStyles.Tlogin,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      height: 90,
                      width: 320,
                      decoration: BoxDecoration(
                        //border: Border.all(color: brown, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: aa,
                            // blurRadius:5.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text('(น้ำหนักตัว/2) x 2.2 x 30',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text(' =  ', style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text('ปริมาณน้ำที่ควรได้รับ',
                                  style: TextStyles.common2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'ปริมาณโซเดียม น้ำตาล ไขมัน ที่ควรได้รับ',
                  style: TextStyles.Tlogin,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      height: 190,
                      width: 320,
                      decoration: BoxDecoration(
                        //border: Border.all(color: brown, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: aa,
                            // blurRadius:5.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('ปริมาณโซเดียม',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text('ไม่เกิน1500-2300 มิลลิกรัมต่อวัน',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('ปริมาณน้ำตาล',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text('เด็กและผู้สูงอายุ ไม่เกิน 16 กรัม',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text(' วัยรุ่นและวัยทำงาน ไม่เกิน 24 กรัม',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('ปริมาณไขมัน',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text('ไม่เกิน 30 กรัมต่อวัน',
                                  style: TextStyles.common2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
               
                Text(
                  'ระดับการออกกำลังกาย',
                  style: TextStyles.Tlogin,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      height: 260,
                      width: 320,
                      decoration: BoxDecoration(
                        //border: Border.all(color: brown, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: aa,
                            // blurRadius:5.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text(
                                  'Total Daily Energy Expenditure (TDEE)',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('- ไม่ออกกำลังกายหรือทำงานนั่งโต๊ะ',
                                  style: TextStyles.common2),
                            ),
                            Align(
                              child: Text('TDEE = BMRx1.2',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '- ออกกำลังกายเบาๆ (1-2 ครั้งต่อสัปดาห์)',
                                  style: TextStyles.common2),
                            ),
                            Align(
                              child: Text('TDEE = BMRx1.375',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '- ออกกำลังกายปานกลาง (3-5 ครั้งต่อสัปดาห์)',
                                  style: TextStyles.common2),
                            ),
                            Align(
                              child: Text('TDEE = BMRx1.55',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '- ออกกำลังกายหนัก (6-7 ครั้งต่อสัปดาห์)',
                                  style: TextStyles.common2),
                            ),
                            Align(
                              child: Text('TDEE = BMRx1.725',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '- ออกกำลังกายหนักมาก (ทุกวัน วันละ 2 เวลา)',
                                  style: TextStyles.common2),
                            ),
                            Align(
                              child: Text('TDEE = BMRx1.9',
                                  style: TextStyles.common2),
                            ),
                            SizedBox(
                              height: 5,
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
      ),
    );
  }
}
