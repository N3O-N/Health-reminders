import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class TrianglePosePage extends StatefulWidget {
  @override
  State<TrianglePosePage> createState() => _TrianglePosePageState();
}

class _TrianglePosePageState extends State<TrianglePosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ท่าตรีโกณ"),

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
                'asset/image/yoga-5.jpg',
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
                    'โยคะ ท่าตรีโกณ เริ่มจากยืนตรง จากนั้นกางขากว้างออกด้านข้าง ให้ขากว้างกว่าช่วงสะโพก โดยให้ปลายเท้าด้านขวาชี้ออกทางด้านข้าง และปลายเท้าซ้ายชี้ไปด้านหน้า หายใจเข้า กางแขนทั้งสองข้างออกด้านข้างขนานกับพื้น ให้ความสูงอยู่แนวเดียวกับหัวไหล่ หายใจออก พร้อมกับค่อยๆ เอนตัวทางด้านขวาลงไปหาเท้าขวา และใช้มือขวาวางลงบนพื้นใกล้ๆ ฝ่าเท้า ถ้าวางมือบนพื้นไม่ถึง สามารถใช้ปลายนิ้วจรดพื้น หรือจับที่บริเวณข้อเท้าได้ สายตามองขึ้นไปที่เพดาน และค้างไว้ 5-10 ลมหายใจเข้าออก กลับมายืนตรงในท่าเดิมและสลับทำอีกข้าง',
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
                          child: Text('เน้นการยืดกล้ามเนื้อขา สะโพก ข้างลำตัว',
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
