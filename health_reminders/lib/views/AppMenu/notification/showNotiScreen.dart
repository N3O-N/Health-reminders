import 'package:flutter/material.dart';

import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/views/AppMenu/notification/addNotiScreen.dart';
import 'package:page_transition/page_transition.dart';

class showNotiScreen extends StatefulWidget {
  final String userId;
  final String titleNoti;
  final String labelNotiText;
  const showNotiScreen(
      {super.key,
      required this.userId,
      required this.titleNoti,
      required this.labelNotiText});

  @override
  State<showNotiScreen> createState() => _showNotiScreenState();
}

class _showNotiScreenState extends State<showNotiScreen> {
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
          widget.titleNoti,
          style: TextStyle(
            color: brown, // Assuming 'brown' is a defined color variable
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
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: addNotiScreen(
                    userId: widget.userId,
                    titleNoti: widget.titleNoti,
                    labelNotiText: widget.labelNotiText,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                BuildNotificationListView(
                  userId: widget.userId,
                  label: widget.titleNoti,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
