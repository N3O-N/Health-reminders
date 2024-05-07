import 'package:flutter/material.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/views/Home/home.dart';
import 'package:page_transition/page_transition.dart';

class calcaloriePage extends StatefulWidget {
  final String userId;

  const calcaloriePage({required this.userId});

  @override
  State<calcaloriePage> createState() => _calcaloriePageState();
}

class _calcaloriePageState extends State<calcaloriePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: homePage(
                  userId: widget.userId,
                ),
              ),
            );
          },
          title: "คำนวณแคลอรี่"),
      body: showDataPlugin(
        docId: widget.userId,
        otherClass: (context, usersData, healthData) => summaryCaloriesWidget(
            usersDataSet: usersData, healthDataSet: healthData),
      ),
    );
  }
}
