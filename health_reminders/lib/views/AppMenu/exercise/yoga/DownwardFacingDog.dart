import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class DownwardFacingDogPage extends StatefulWidget {
  @override
  State<DownwardFacingDogPage> createState() => _DownwardFacingDogPageState();
}

class _DownwardFacingDogPageState extends State<DownwardFacingDogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ท่าสุนัขก้มหน้า"),

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
                'asset/image/yoga-1.jpg',
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
                    ' โยคะ ท่าสุนัขก้มหน้า โดยเริ่มจากท่าคลาน วางเข่าทั้ง 2 ข้างและมือวางบนพื้น โดยให้เข่ากว้างเท่าช่วงสะโพก และให้เข่าอยู่แนวเดียวกับสะโพก มือทั้งสองข้างวางกว้างเท่าช่วงไหล่ กางนิ้วให้กว้าง หลังตรง ไม่เกร็งไหล่ จากนั้นหายใจออก ดันเข่ายกขึ้นทั้ง 2 ข้าง ทำให้ร่างกายอยู่ในรูปตัว V กลับหัว แขนและขาเหยียดตรง พยายามกดส้นเท้าให้ติดพื้น หากรู้สึกว่าขาตึงเกินไป สามารถงอเข่าได้เล็กน้อย ไม่ยกและเกร็งไหล่ ค้างท่าไว้ประมาณ 3 ลมหายใจเข้าออก',
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
