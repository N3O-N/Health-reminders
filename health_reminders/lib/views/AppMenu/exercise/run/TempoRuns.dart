import 'package:flutter/material.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class TempoRunsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: "Tempo Runs",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
         
          children: [
            SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'asset/image/tempo.jpg',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'วิ่งด้วยความเร็วสม่ำเสมอเป็นรูปแบบการวิ่งที่มีจุดประสงค์ในการพัฒนาความทนทานของระบบหัวใจและการไหลเวียนเลือด (anaerobic endurance) รวมถึงความทนทานของกล้ามเนื้อ (muscular endurance) เพื่อให้กล้ามเนื้อทนต่อความเมื่อยล้าที่เกิดขึ้นจาก lactic acid หรือของเสียที่ร่างกายขับออกมาในขณะทำงานอย่างหนัก',
              style: TextStyles.common2,
              softWrap: true,
                    overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}
