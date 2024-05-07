import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/exercise/run/IntervalRuns.dart';
import 'package:health_reminders/views/AppMenu/exercise/run/LongRuns.dart';
import 'package:health_reminders/views/AppMenu/exercise/run/TempoRuns.dart';

class runPage extends StatefulWidget {
  @override
  _runPageState createState() => _runPageState();
}

class _runPageState extends State<runPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "การวิ่ง"),
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
                                  builder: (context) => LongRunsPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/longruns.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('การวิ่งยาว', style: TextStyles.Tlogin),
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
                                  builder: (context) => TempoRunsPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/tempos.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('การวิ่งสม่ำเสมอ', style: TextStyles.Tlogin),
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
                padding: const EdgeInsets.only(left: 20.0, right: 200.0),
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
                            print('Button 3 Pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IntervalRunsPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/intervalruns.png',
                                width: 110,
                                height: 110,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('การวิ่งเบาสลับหนัก', style: TextStyles.Tlogin),
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
