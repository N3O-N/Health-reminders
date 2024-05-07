import 'package:flutter/material.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:toggle_switch/toggle_switch.dart';

class bmi_bmr_page extends StatefulWidget {
  final String userId;

  bmi_bmr_page({required this.userId});
  @override
  State<bmi_bmr_page> createState() => _bmi_bmr_pageState();
}

class _bmi_bmr_pageState extends State<bmi_bmr_page> {
  int _toggleValue = 0;

  final TextEditingController ageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "BMI/BMR"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              minWidth: 150.0,
              initialLabelIndex: _toggleValue,
              totalSwitches: 2,
              activeBgColors: [
                [yellow],
                [yellow]
              ],
              activeFgColor: brown,
              inactiveBgColor: white,
              inactiveFgColor: brown,
              labels: ['BMI', 'BMR'],
              onToggle: (index) {
                setState(() {
                  _toggleValue = index!;
                });
              },
            ),
            SizedBox(height: 20),
            _toggleValue == 0 ? _buildBMIContent() : _buildBMRContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIContent() {
    // Customize the BMI content here
    return SingleChildScrollView(
      child: Container(
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    showDataPlugin(
                      docId: widget.userId,
                      otherClass: (context, usersData, healthData) =>
                          BMI_Widget(healthDataSet: healthData),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'คำนวณค่าดัชนีมวลกาย (BMI)',
                  style: TextStyles.common4,
                ),
              ]),
            ),
            showDataPlugin(
              docId: widget.userId,
              otherClass: (context, usersData, healthData) =>
                  WeightHeight_Widget(healthDataSet: healthData),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 140,
                  width: 330,
                  decoration: BoxDecoration(
                    //border: Border.all(color: brown, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                        color: aa,
                        // blurRadius:5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 11, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'สูตรคำนวณ',
                            style: TextStyles.Tlogin,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('BMI =', style: TextStyles.common2),
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text('น้ำหนักตัว (กิโลกรัม)',
                                        style: TextStyles.common2),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text('÷', style: TextStyles.common3),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        'ส่วนสูง (เมตร) x ส่วนสูง (เมตร)',
                                        style: TextStyles.common2),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMRContent() {
    // Customize the BMR content here
    return SingleChildScrollView(
      child: Container(
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showDataPlugin(
                  docId: widget.userId,
                  otherClass: (context, usersData, healthData) =>
                      BMR_Widget(healthDataSet: healthData),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'คำนวณอัตราการเผาพลาญ (BMR)',
                  style: TextStyles.common4,
                ),
              ]),
            ),
            showDataPlugin(
              docId: widget.userId,
              otherClass: (context, usersData, healthData) => SexAge_Widget(
                healthDataSet: healthData,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            showDataPlugin(
              docId: widget.userId,
              otherClass: (context, usersData, healthData) =>
                  WeightHeight_Widget(healthDataSet: healthData),
            ),
            SizedBox(
              height: 1,
            ),
            showDataPlugin(
              docId: widget.userId,
              otherClass: (context, usersData, healthData) =>
                  ExerciseLevel_Widget(healthDataSet: healthData),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 190,
                  width: 330,
                  decoration: BoxDecoration(
                    //border: Border.all(color: brown, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                        color: aa,
                        // blurRadius:5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'สูตรคำนวณ',
                          style: TextStyles.Tlogin,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('ผู้ชาย', style: TextStyles.common3),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              'BMR = 66 + (13.7 x น้ำหนักตัว กก.) + (5 x ส่วนสูง ซม.) - (6.8 x อายุ) ',
                              style: TextStyles.common2),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('ผู้หญิง', style: TextStyles.common3),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              'BMR = 665 + (9.6 x น้ำหนักตัว กก.) + (1.8 x ส่วนสูง ซม.) - (4.7 x อายุ)',
                              style: TextStyles.common2),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('TDEE = BMR x ระดับการออกกำลังกาย',
                              style: TextStyles.common2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
