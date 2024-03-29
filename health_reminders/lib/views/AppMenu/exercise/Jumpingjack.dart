import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class JumpingjackPage extends StatefulWidget {
  @override
  State<JumpingjackPage> createState() => _JumpingjackPageState();
}

class _JumpingjackPageState extends State<JumpingjackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "Jumping Jack"),

      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: [
              SizedBox(
                height: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'asset/image/cardio-1.jpg',
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
                      ' 1 นอนราบกับพื้น ยกขาทั้งสองข้างขึ้นตั้งฉาก ยกศีรษะขึ้นจากพื้น มือทั้งสองข้างแตะไว้ที่ด้านหลังศีรษะ',
                      style: TextStyles.common2,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      ' 2 ยกลำตัวด้านบนขึ้นเอียงไปด้านซ้าย ให้ศอกขวาแตะที่เข่าซ้าย พร้อมกับเหยียดขาขวาตรงไปด้านหน้า',
                      style: TextStyles.common2,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      ' 3 สลับข้าง บิดลำตัวเอียงไปด้านขวา ให้ศอกซ้ายแตะที่เข่าขวา พร้อมกับเหยียดขาซ้ายตรงไปด้านหน้า นับเป็น 1 ครั้ง ทำซ้ำจนครบ 15-20 ครั้ง',
                      style: TextStyles.common2,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ]),
            ]),
          ),
        ),
      ),
    );
  }
}