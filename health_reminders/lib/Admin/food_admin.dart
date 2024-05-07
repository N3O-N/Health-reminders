import 'package:flutter/material.dart';
import 'package:health_reminders/controller/plugin.dart';

import 'package:health_reminders/styles/color.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:health_reminders/Admin/admin_add_food.dart';

class food_adminPage extends StatefulWidget {
  @override
  State<food_adminPage> createState() => _food_adminPageState();
}

class _food_adminPageState extends State<food_adminPage> {
  int _toggleValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
            icon: Icon(
              Icons.add_circle_outline,
              color: brown,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => admin_add_foodPage()),
              );
            },
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
                [yellow],
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
                                : _buildFoodContent('ผัก')),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodContent(String label) {
    return BuildListViewForWeb(
      label: 'foods',
      type: label,
    );
  }
}
