import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_reminders/controller/plugin.dart';

import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/menu/Addmenucal_Page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toggle_switch/toggle_switch.dart';

class foodPage extends StatefulWidget {
  final String userId;

  const foodPage({required this.userId});

  @override
  State<foodPage> createState() => _foodPageState();
}

class _foodPageState extends State<foodPage> {
  int _toggleValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'อาหาร',
          style: TextStyle(
            color: Colors.brown, // Assuming 'brown' is a defined color variable
            fontFamily: 'Garuda',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Column(
              children: [
                /*Icon(
                  Icons.food_bank_sharp,
                  color: brown,
                ),*/
                Text(
                  'สร้างเมนู',
                  style: TextStyles.Tlogin,
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: addmenucalPage(
                    userId: widget.userId,
                  ),
                ),
              );
            },
            tooltip: 'สร้างเมนู',
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ToggleSwitch(
              minWidth: 150.0,
              initialLabelIndex: _toggleValue,
              totalSwitches: 5,
              activeBgColors: [
                [yellow],
                [yellow],
                [yellow],
                [yellow],
                [yellow]
              ],
              activeFgColor: brown,
              inactiveBgColor: white,
              inactiveFgColor: brown,
              labels: [
                'คาว',
                'หวาน',
                'เครื่องดื่ม',
                'ผลไม้',
                'ผัก',
              ],
              onToggle: (index) {
                setState(() {
                  _toggleValue = index!;
                });
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: _toggleValue == 0
                  ? _buildFoodContent('ของคาว')
                  : _toggleValue == 1
                      ? _buildFoodContent('ของหวาน')
                      : _toggleValue == 2
                          ? _buildFoodContent('เครื่องดื่ม')
                          : _toggleValue == 3
                              ? _buildFoodContent('ผลไม้')
                              : _buildFoodContent('ผัก'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodContent(String label) {
    return showDataPlugin(
      docId: widget.userId,
      otherClass: (context, usersData, healthData) => BuildFoodListView(
        usersDataSet: usersData,
        healthDataSet: healthData,
        label: label,
      ),
    );
  }
}
