import 'package:flutter/material.dart';

import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/exercise/cadio/BicycleCrunch.dart';
import 'package:health_reminders/views/AppMenu/exercise/cadio/Jumpingjack.dart';
import 'package:health_reminders/views/AppMenu/exercise/cadio/LungeJump.dart';
import 'package:health_reminders/views/AppMenu/exercise/cadio/MountainClimber.dart';
import 'package:health_reminders/views/AppMenu/exercise/cadio/PushUpBurpee.dart';
import 'package:health_reminders/views/AppMenu/exercise/cadio/SquatJump.dart';
import 'package:health_reminders/views/AppMenu/exercise/run/LongRuns.dart';

class cadioPage extends StatefulWidget {
  @override
  _cadioPageState createState() => _cadioPageState();
}

class _cadioPageState extends State<cadioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "คาร์ดิโอ"),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double
                            .infinity, // ตั้งค่าเป็น double.infinity เพื่อให้ช่องว่างทั้งหมดเท่ากัน
                        height: 200.0,
                        child: ElevatedButton(
                          style: buttonmanu,
                          onPressed: () {
                            // Handle the first button press
                            print('Button 1 Pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JumpingjackPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/jj.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('ท่ากระโดดตบ', style: TextStyles.Tlogin),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        child: ElevatedButton(
                          style: buttonmanu,
                          onPressed: () {
                            // Handle the first button press
                            print('Button 2 Pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BicycleCrunchPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/bc.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('ท่าปั่นจักรยานอากาศ', style: TextStyles.Tlogin),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double
                            .infinity, // ตั้งค่าเป็น double.infinity เพื่อให้ช่องว่างทั้งหมดเท่ากัน
                        height: 200.0,
                        child: ElevatedButton(
                          style: buttonmanu,
                          onPressed: () {
                            // Handle the first button press
                            print('Button go to exercisepage');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MountainClimberPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/mc.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('ท่าปีนเขา',
                                  style: TextStyles.Tlogin),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        child: ElevatedButton(
                          style: buttonmanu,
                          onPressed: () {
                            // Handle the first button press
                            print('Button 2 Pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SquatJumpPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/sj.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('ท่าสควอทจั๊มพ์', style: TextStyles.Tlogin),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        child: ElevatedButton(
                          style: buttonmanu,
                          onPressed: () {
                            // Handle the first button press
                            print('Button 2 Pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LungeJumpPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/lj.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('ท่ากระโดดสลับย่อขา', style: TextStyles.Tlogin),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        child: ElevatedButton(
                          style: buttonmanu,
                          onPressed: () {
                            // Handle the first button press
                            print('Button 2 Pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PushUpBurpeePage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/bp.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('ท่าพุ่งหลัง', style: TextStyles.Tlogin),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
