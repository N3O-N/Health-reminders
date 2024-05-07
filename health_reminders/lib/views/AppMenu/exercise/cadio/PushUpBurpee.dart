import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class PushUpBurpeePage extends StatefulWidget {
  @override
  State<PushUpBurpeePage> createState() => _PushUpBurpeePageState();
}

class _PushUpBurpeePageState extends State<PushUpBurpeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ท่าพุ่งหลัง"),

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
                'asset/image/cardio-6.jpg',
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' 1.ยืนตรง มือทั้งสองข้างแนบข้างลำตัว',
                    style: TextStyles.common2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    ' 2.ย่อเข่าลง ใช้มือทั้งสองข้างยันพื้นไว้',
                    style: TextStyles.common2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    ' 3.ออกแรงกระโดดดันขาทั้งสองข้างไปด้านหลัง อยู่ในท่าวิดพื้น',
                    style: TextStyles.common2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    ' 4.ดันตัวลงโดยงอสอก ลดแขนลงต่ำ',
                    style: TextStyles.common2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    ' 5.ดันตัวขึ้นยืนพร้อมกระโดด มือทั้งสองข้างชูขึ้นเหนือศีรษะ',
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
                          child: Text(
                              'เสริมกล้ามเนื้อท้อง แขน ขา',
                              style: TextStyles.common3),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('อัตราการเผาพลาญ 10-15 กิโลแคลอรี่ต่อนาที',
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
