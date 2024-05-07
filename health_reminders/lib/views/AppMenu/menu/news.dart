import 'package:flutter/material.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';

class newsPage extends StatefulWidget {
  final String userId;

  const newsPage({required this.userId});

  @override
  State<newsPage> createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: "ข่าวสารสุขภาพ"),
      body: Center(
        child: showDataPlugin(
          docId: widget.userId,
          otherClass: (context, usersData, healthData) => BuildNewsListView(),
        ),
      ),
    );
  }
}
