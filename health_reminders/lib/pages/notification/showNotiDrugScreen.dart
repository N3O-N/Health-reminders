import 'package:flutter/material.dart';
import 'package:health_reminders/pages/notification/addNotiDrugScreen.dart';

import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class showNotiDrugScreen extends StatefulWidget {
  @override
  State<showNotiDrugScreen> createState() => _showNotiDrugScreenState();
}

class _showNotiDrugScreenState extends State<showNotiDrugScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'เวลารับประทานยา',
          style: TextStyle(
            color: Colors.brown, // Assuming 'brown' is a defined color variable
            fontFamily: 'Garuda',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
                MaterialPageRoute(builder: (context) => addNotiDrugScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'asset/image/drug.png',
                width: 200,
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
