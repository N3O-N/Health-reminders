import 'package:flutter/material.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/menu/edit_account.dart';
import 'package:page_transition/page_transition.dart';

class account_settingPage extends StatelessWidget {
  final String userId;

  const account_settingPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading:
                  true, // This property is redundant and not needed here
              centerTitle: true,
              backgroundColor: white,
              elevation: 0.0,
              title: Text(
                'โปรไฟล์',
                style: TextStyle(
                  color: Colors
                      .brown, // Assuming 'brown' is a defined color variable
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
                    Icons.edit,
                    color: brown,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: edit_accountPage(
                          userId: userId,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            showDataPlugin(
              docId: userId,
              otherClass: (context, usersData, healthData) => profileWidget(
                  usersDataSet: usersData, healthDataSet: healthData),
            ),
          ],
        ),
      ),
    );
  }
}
