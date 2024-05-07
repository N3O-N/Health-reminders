import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class CobraPosePage extends StatefulWidget {
  @override
  State<CobraPosePage> createState() => _CobraPosePageState();
}

class _CobraPosePageState extends State<CobraPosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ท่างู"),

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
                'asset/image/yoga-6.jpg',
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
                    'โยคะ ท่างู เริ่มต้นท่าด้วยการนอนคว่ำ โดยที่ใบหน้าราบลงไปบนพื้น จากนั้นให้วางฝ่ามือข้างหน้าอกทั้งสองข้าง ส่วนขาให้ยืดตรงไปด้านหลัง คว่ำหลังเท้าแนบลงกับพื้น หายใจเข้า ใช้แขนดันตัวขึ้นจนลำตัวด้านบนไม่สัมผัสพื้น โดยไม่ให้มีอาการปวดหลัง เงยหน้าขึ้นด้านบนเล็กน้อย สามารถงอศอกไว้ได้เล็กน้อย ระหว่างทำไม่ควรยกไหล่ ให้กดไหล่ลงให้ห่างจากหู ค้างไว้ 15-30 วินาที ระหว่างค้างท่าให้หายใจเข้าออกตลอดเวลา คลายท่ากลับไปท่าคว่ำเหมือนเดิม จากนั้นทําซ้ำ',
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
                          child: Text('เน้นกล้ามเนื้อหลัง',
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
