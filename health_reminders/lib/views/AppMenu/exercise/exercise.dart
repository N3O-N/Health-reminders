import 'package:flutter/material.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/exercise/aerobic/aerobic.dart';
import 'package:health_reminders/views/AppMenu/exercise/cadio/cadio.dart';
import 'package:health_reminders/views/AppMenu/exercise/run/run.dart';
import 'package:health_reminders/views/AppMenu/exercise/yoga/yoga.dart';
import 'package:page_transition/page_transition.dart';

class exercisePage extends StatefulWidget {
  @override
  State<exercisePage> createState() => _exercisePageState();
}

class _exercisePageState extends State<exercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ออกกำลังกาย"),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: buttonnoti,
                            onPressed: () {
                              // Handle the first button press
                              print('Button 1 Pressed');
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: runPage()),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/exercise.png',
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'การวิ่ง',
                                  style: TextStyles.head,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: buttonnoti,
                            onPressed: () {
                              // Handle the first button press
                              print('go to drug notification');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => cadioPage()),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/cardio.png',
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'คาดิโอ',
                                  style: TextStyles.head,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: buttonnoti,
                            onPressed: () {
                              // Handle the first button press
                              print('go to drug notification');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => yogaPage()),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/yoga.png',
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'โยคะ',
                                  style: TextStyles.head,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: buttonnoti,
                            onPressed: () {
                              print('go to sleepy notification');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => arobicPage()),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/aerobic.png',
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'แอโรบิค',
                                  style: TextStyles.head,
                                ),
                              ],
                            )),
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
