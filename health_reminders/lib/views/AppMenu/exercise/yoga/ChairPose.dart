import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class ChairPosePage extends StatefulWidget {
  @override
  State<ChairPosePage> createState() => _ChairPosePageState();
}

class _ChairPosePageState extends State<ChairPosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "Chair Pose"),

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
                'asset/image/yoga-7.jpg',
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
                    ' โยคะ ท่าเก้าอี้ หรือ ท่านั่ง ท่านี้เริ่มจากยืนตัวตรง แยกขาทั้งสองข้างเล็กน้อย และยกแขนทั้งสองข้างขึ้นเหนือศีรษะโดยพนมมือไว้ จากนั้นค่อยๆ ย่อเข่าลงช้าๆ ดันสะโพกไปด้านหลัง คล้ายกับการนั่งเก้าอี้ ระวังไม่ให้หัวเข่าเลยปลายเท้า หากยังไม่สามารถทรงตัวได้ สามารถทำชิดกับกำแพง โดยให้หลังพิงกำแพงได้ ทำค้างไว้ 30-60 วินาที จากนั้นคลายท่า และทำซ้ำ',
                    style: TextStyles.common2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ]),
          ]),
        ),
      ),
    );
  }
}
